import 'package:flutter/material.dart';
import 'package:saca/views/home.views.dart';

class SignUpView extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenView createState() => _SignUpScreenView();
}

class _SignUpScreenView extends State<SignUpView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 56,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          // border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          // border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          // border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: confirmPasswordController,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha',
                          // border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Registrar'),
                  elevation: 2,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () =>
                      Navigator.pushNamed(context, HomeView.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
