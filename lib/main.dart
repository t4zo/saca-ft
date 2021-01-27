import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/providers.dart';

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
  // configureInjection(Environment.dev);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SACA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.yellow,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              ),
        ),
      ),
      home: FutureBuilder(
        future: context.read(sessionNotifier).tryAutoLoginAsync(),
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
