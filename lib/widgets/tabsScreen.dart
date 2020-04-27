import 'package:flutter/material.dart';
import 'package:saca/screens/home.dart';
import 'package:saca/screens/signIn.dart';
import 'package:saca/screens/signUp.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _screens;
  int _selectScreenIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _screens = [
        {'screen': HomeScreen(), 'title': 'Categorias'},
        {'screen': SignInScreen(), 'title': 'Entrar'},
        {'screen': SignUpScreen(), 'title': 'Registrar'},
      ];
    });
  }

  void _selectScreen(int index) {
    setState(() {
      this._selectScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool _signedIn = true;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_screens[_selectScreenIndex]['title']),
      // ),
      body: _screens[_selectScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectScreenIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text('Figuras'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.supervisor_account),
            title: Text('Entrar'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.perm_identity),
            title: Text('Registrar'),
          ),
        ],
        onTap: _selectScreen,
      ),
    );
  }
}
