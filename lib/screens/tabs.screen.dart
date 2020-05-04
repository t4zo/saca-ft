import 'package:flutter/material.dart';
import 'package:saca/views/home.views.dart';
import 'package:saca/views/signin.views.dart';
import 'package:saca/views/signup.views.dart';

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
        {'screen': HomeView(), 'title': 'Categorias'},
        {'screen': SignInView(), 'title': 'Entrar'},
        {'screen': SignUpView(), 'title': 'Registrar'},
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
            title: Text('Categorias'),
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
