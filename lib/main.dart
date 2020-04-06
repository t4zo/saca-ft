import 'package:flutter/material.dart';

import 'screens/signIn.dart';
import 'screens/signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  bool _flag = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SACA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: DefaultTabController(
          length: _flag ? 3 : 2,
          child: Scaffold(
            body: TabBarView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('Voce apertou no botão $_counter vezes')
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Container(
                  child: SignIn(),
                  color: Colors.white,
                ),
                Container(
                  child: SignUp(),
                  color: Colors.white,
                ),
              ],
            ),
            bottomNavigationBar: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Figuras',
                ),
                Tab(
                  icon: Icon(Icons.supervisor_account),
                  text: 'Entrar'
                ),
                if(_flag) Tab(
                  icon: Icon(Icons.perm_identity),
                  text: 'Registrar'
                ),
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white54,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Adicionar',
              child: Icon(Icons.add),
            ),
            backgroundColor: Colors.blueAccent,
          ),
        ),
        // home: MyHomePage(title: 'SACA'),
      ),
    );
  }

  void _incrementCounter() {
    print('entrou $_counter');
    setState(() {
      _counter++;
    });
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     List<CustomCard> listCustomCard() {
//       return new List.generate(7, (index) => CustomCard(index: index, onPress: () {
//               print('Card $index pressed!');
//             }));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: new Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: listCustomCard()
//         )
//     );

    
//   }
// }
