import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/auth.controller.dart';
import 'package:saca/stores/session.store.dart';

import 'package:saca/stores/user.store.dart';
import 'package:saca/stores/category.store.dart';

import 'package:saca/navigations/tab.navigation.dart';
import 'package:saca/views/splashscreen.view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>(create: (_) => UserStore()),
        Provider<SessionStore>(create: (_) => SessionStore()),
        Provider<CategoryStore>(create: (_) => CategoryStore()),
      ],
      child: Saca(),
    );
  }
}

class Saca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authController = AuthController();

    return MaterialApp(
      title: 'SACA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent[200],
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              ),
        ),
      ),
      home: FutureBuilder(
        future: _authController.tryAutoLogin(context),
        builder: (ctx, snp) => snp.connectionState == ConnectionState.done
            ? TabsScreen()
            : SplashScreen(),
      ),
      // initialRoute: '/',
      routes: {
        // '/': (ctx) => TabsScreen(),
        // CreateImage.routeName: (ctx) => CreateImage(),
      },
      onGenerateRoute: (settings) {
        // print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => TabsScreen(),
        );
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => TabsScreen(),
      ),
    );
  }
}
