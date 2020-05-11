import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:saca/stores/user.store.dart';
import 'package:saca/stores/category.store.dart';

import 'package:saca/navigations/tab.navigation.dart';
import 'package:saca/views/Images/create.view.dart';

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CategoryStore>(create: (_) => CategoryStore()),
        Provider<UserStore>(create: (_) => UserStore()),
      ],
      // return Provider<AppStore>(
      // create: (_) => AppStore(),
      child: MaterialApp(
        title: 'SACA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent[200],
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          CreateImage.routeName: (ctx) => CreateImage(),
          // SignUpView.routeName: (ctx) => SignUpView(),
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
      ),
    );
  }
}
