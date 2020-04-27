import 'package:flutter/material.dart';
import 'package:saca/screens/home.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                scale: 4,
                semanticLabel: 'Logo SACA',
              ),
              // Text(
              //   'SACA',
              //   style: TextStyle(fontSize: 40),
              // ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
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
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
