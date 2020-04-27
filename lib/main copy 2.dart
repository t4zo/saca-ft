// import 'package:flutter/material.dart';

// import 'package:saca/screens/home.dart';
// import 'package:saca/screens/signIn.dart';
// import 'package:saca/screens/signUp.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   static const _app = 'SACA';
//   bool _signedIn = true;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _app,
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         accentColor: Colors.amberAccent[200],
//         errorColor: Colors.red,
//         fontFamily: 'Quicksand',
//         appBarTheme: AppBarTheme(
//           textTheme: ThemeData.light().textTheme.copyWith(
//                 title: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
//               ),
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(_app),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.add,
//                 color: Theme.of(context).accentColor,
//               ),
//               onPressed: () {},
//             )
//           ],
//         ),
//         body: DefaultTabController(
//           length: _signedIn ? 3 : 2,
//           child: Scaffold(
//             body: TabBarView(
//               children: <Widget>[
//                 Container(
//                   child: Home(),
//                 ),
//                 Container(
//                   child: SignIn(),
//                 ),
//                 Container(
//                   child: SignUp(),
//                 ),
//               ],
//             ),
//             bottomNavigationBar: TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.home),
//                   text: 'Figuras',
//                 ),
//                 Tab(icon: Icon(Icons.supervisor_account), text: 'Entrar'),
//                 if (_signedIn)
//                   Tab(icon: Icon(Icons.perm_identity), text: 'Registrar'),
//               ],
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorPadding: EdgeInsets.all(5.0),
//               labelColor: Theme.of(context).primaryColor,
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {},
//               tooltip: 'Adicionar',
//               child: IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {},
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
