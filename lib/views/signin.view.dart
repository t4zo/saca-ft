import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/providers.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/views/categories.view.dart';

class SignInView extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  var signInViewModel = SignInViewModel(busy: false);
  var _initialValues = {'email': '', 'password': ''};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _userNotifier = context.read(userStateNotifier.state);

    if (_userNotifier.isAuthenticated) {
      _initialValues = {
        'email': _userNotifier.user.email,
        'password': '**********',
      };
    }
  }

  @override
  void dispose() {
    super.dispose();

    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Consumer(builder: (context, watch, child) {
              final _userStateNotifier = watch(userStateNotifier.state);
              return Container(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 4,
                        semanticLabel: 'Logo SACA',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              initialValue: _initialValues['email'],
                              enabled: !_userStateNotifier.isAuthenticated,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                              decoration: const InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value.isEmpty) return 'Por favor, informe seu email';
                                return null;
                              },
                              onSaved: (value) => signInViewModel.email = value,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              // initialValue: _initialValues['password'],
                              obscureText: true,
                              enabled: !_userStateNotifier.isAuthenticated,
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocusNode,
                              decoration: const InputDecoration(labelText: 'Senha'),
                              validator: (value) {
                                if (value.isEmpty) return 'Por favor, informe sua senha';
                                return null;
                              },
                              onSaved: (value) => signInViewModel.password = value,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FlatButton(
                                padding: const EdgeInsets.only(left: 0),
                                child: context.read(userStateNotifier.state).isAuthenticated
                                    ? Text('Remover conta', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700))
                                    : Text('Esqueceu a senha?'),
                                onPressed: () => _userStateNotifier.isAuthenticated ? _handleRemoveAccount : _handleRecoverPassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: signInViewModel.busy
                          ? SizedBox(height: 15, child: const CircularProgressIndicator(strokeWidth: 3))
                          : Text(!context.read(userStateNotifier.state).isAuthenticated ? 'Entrar' : 'Sair'),
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.headline6.color,
                      onPressed: _handleSignInAndSignOutAsync,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<String> _signInAsync() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return "Algum campo está inválido";

    _form.currentState.save();

    final result = await context.read(sessionNotifier).signInAsync(signInViewModel);

    return result;
  }

  Future _handleSignInAndSignOutAsync() async {
    final _userStateNotifier = context.read(userStateNotifier.state);

    setState(() {
      signInViewModel.busy = true;
    });

    if (!_userStateNotifier.isAuthenticated) {
      final result = await _signInAsync();
      if (result.isEmpty) {
        Navigator.pushNamed(context, CategoriesView.routeName);
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(result),
        ));
      }
    } else {
      context.read(sessionNotifier).signOutAsync();
      _initialValues['password'] = '';
    }

    setState(() {
      signInViewModel.busy = false;
    });
  }

  void _handleRemoveAccount() {}

  void _handleRecoverPassword() {}
}
