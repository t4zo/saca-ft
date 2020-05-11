import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/auth.controller.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/views/home.view.dart';

class SignInView extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _form = GlobalKey<FormState>();

  final _passwordFocusNode = FocusNode();

  var model = SignInViewModel(busy: false);

  var _initialValues = {'email': '', 'password': ''};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _userStore = Provider.of<UserStore>(context, listen: false);

    if (_userStore.isAuthenticated) {
      _initialValues = {
        'email': _userStore.user.email,
        'password': '**********',
      };
    }
  }

  @override
  void dispose() {
    super.dispose();

    _passwordFocusNode.dispose();
  }

  void _signIn() {
    final isValid = _form.currentState.validate();
    if (!isValid) return;

    _form.currentState.save();

    AuthController().authenticate(model, context);
  }

  void _signOut() {
    AuthController().signOut(context);
  }

  void _handleSignInAndOut() {
    final _userStore = Provider.of<UserStore>(context, listen: false);

    setState(() {
      model.busy = true;
    });

    // Timer(Duration(seconds: 5), () {
    if (!_userStore.isAuthenticated) {
      _signIn();
      Navigator.pushNamed(context, HomeView.routeName);
    } else {
      _signOut();
      _initialValues['password'] = '';
    }

    setState(() {
      model.busy = false;
    });
    // });
  }

  void _handleRemoveAccount() {}

  void _handleRecoverPassword() {}

  @override
  Widget build(BuildContext context) {
    final _userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  56,
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
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15),
                    child: Form(
                      key: _form,
                      child: Observer(
                        builder: (ctx) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              initialValue: _initialValues['email'],
                              enabled: !_userStore.isAuthenticated,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) => FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Por favor, informe seu email';
                                return null;
                              },
                              onSaved: (value) => model.email = value,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              // initialValue: _initialValues['password'],
                              obscureText: true,
                              enabled: !_userStore.isAuthenticated,
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocusNode,
                              decoration:
                                  const InputDecoration(labelText: 'Senha'),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Por favor, informe sua senha';
                                return null;
                              },
                              onSaved: (value) => model.password = value,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FlatButton(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  _userStore.isAuthenticated
                                      ? 'Remover conta'
                                      : 'Esqueceu a senha?',
                                ),
                                onPressed: () => _userStore.isAuthenticated
                                    ? _handleRemoveAccount
                                    : _handleRecoverPassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Observer(
                    builder: (ctx) => RaisedButton(
                      child: model.busy
                          ? SizedBox(
                              height: 15,
                              child: const CircularProgressIndicator(
                                  strokeWidth: 3),
                            )
                          : Text(
                              !_userStore.isAuthenticated ? 'Entrar' : 'Sair',
                            ),
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.title.color,
                      onPressed: _handleSignInAndOut,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
