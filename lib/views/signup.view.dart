import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/auth.controller.dart';
import 'package:saca/stores/session.store.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/view-models/signup.viewmodel.dart';
import 'package:saca/views/categories.view.dart';

class SignUpView extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenView createState() => _SignUpScreenView();
}

class _SignUpScreenView extends State<SignUpView> {
  final _authController = AuthController();

  final _form = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var signUpViewModel = SignUpViewModel();

  Future _handleSignUp() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;

    _form.currentState.save();
    try {
      final result = await _authController.signUp(signUpViewModel);
      if (result)
        _authController.authenticate(
          SignInViewModel(
              email: signUpViewModel.email, password: signUpViewModel.password),
          Provider.of<UserStore>(context, listen: false),
          Provider.of<SessionStore>(context, listen: false),
        );
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context, listen: false);

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
                  Image.asset(
                    'assets/images/logo.png',
                    scale: 4,
                    semanticLabel: 'Logo SACA',
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15),
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            decoration: InputDecoration(
                              labelText: 'Usuário',
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Por favor, informe seu usuário';
                              return null;
                            },
                            onSaved: (value) =>
                                signUpViewModel.username = value,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Por favor, informe seu email';
                              return null;
                            },
                            onSaved: (value) => signUpViewModel.email = value,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocusNode),
                            autocorrect: false,
                            obscureText: true,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                            ),
                            validator: (value) {
                              if (value.length < 6)
                                return 'Informe uma senha maior que 5 caractéres';
                              if (!value.contains(RegExp(r'[A-Za-z]')) ||
                                  !value.contains(RegExp(r'[0-9]')))
                                return 'Deve conter letras e números';
                              if (value != _confirmPasswordController.text)
                                return 'Senhas não conferem';
                              return null;
                            },
                            onSaved: (value) =>
                                signUpViewModel.password = value,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            autocorrect: false,
                            obscureText: true,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              labelText: 'Confirmar Senha',
                            ),
                            validator: (value) {
                              if (value != _passwordController.text)
                                return 'Senhas não conferem';
                              return null;
                            },
                            onSaved: (value) =>
                                signUpViewModel.confirmPassword = value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Observer(
                    builder: (ctx) => RaisedButton(
                        child: Text('Registrar'),
                        elevation: 2,
                        color: Theme.of(context).primaryColor,
                        textColor:
                            Theme.of(context).primaryTextTheme.headline6.color,
                        onPressed: () async {
                          await _handleSignUp();
                          if (userStore.isAuthenticated)
                            Navigator.pushNamed(
                                context, CategoriesView.routeName);
                        }),
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
