import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/views/categories.view.dart';
import 'package:saca/views/images.view.dart';
import 'package:saca/views/signin.view.dart';
import 'package:saca/views/signup.view.dart';
import 'package:saca/stores/user.store.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _screens;
  int _selectScreenIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      _screens = [
        {'screen': ImagesView(), 'title': 'Imagens'},
        {'screen': CategoriesView(), 'title': 'Categorias'},
        {'screen': SignInView(), 'title': 'Entrar'},
        {'screen': SignUpView(), 'title': 'Registrar'},
      ];
    });
  }

  void _selectScreen(int index) {
    setState(() {
      _selectScreenIndex = index;
    });
  }

  void _bottomTapped(int index) {
    setState(() {
      _selectScreenIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_screens[_selectScreenIndex]['title']),
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => _selectScreen(index),
        children: _screens.map((screen) => screen['screen'] as Widget).toList(),
      ),
      bottomNavigationBar: Observer(
        builder: (_) => BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          onTap: (index) => _bottomTapped(index),
          currentIndex: _selectScreenIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.image),
              title: Text('Imagens'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('Categorias'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(!_userStore.isAuthenticated
                  ? Icons.supervisor_account
                  : Icons.exit_to_app),
              title: Text(!_userStore.isAuthenticated ? 'Entrar' : 'Sair'),
            ),
            if (!_userStore.isAuthenticated)
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.perm_identity),
                title: Text('Registrar'),
              ),
          ],
        ),
      ),
    );
  }
}
