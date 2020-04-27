import 'package:flutter/material.dart';
import 'package:saca/screens/home.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      // border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Esqueceu a senha?')],
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Entrar'),
              elevation: 2,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
