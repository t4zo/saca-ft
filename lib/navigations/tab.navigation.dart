import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/providers.dart';
import 'package:saca/views/categories.view.dart';
import 'package:saca/views/images.view.dart';
import 'package:saca/views/signin.view.dart';
import 'package:saca/views/signup.view.dart';

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
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => _selectScreen(index),
        children: _screens.map((screen) => screen['screen'] as Widget).toList(),
      ),
      bottomNavigationBar: Container(
        child: Consumer(
          builder: (context, watch, child) {
            final _userStateNotifier = watch(userStateNotifier.state);

            return Container(
              child: BottomNavigationBar(
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
                    title: const Text('Imagens'),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Icon(Icons.category),
                    title: const Text('Categorias'),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Icon(!_userStateNotifier.isAuthenticated
                        ? Icons.supervisor_account
                        : Icons.exit_to_app),
                    title: Text(!_userStateNotifier.isAuthenticated
                        ? 'Entrar'
                        : 'Sair'),
                  ),
                  if (!_userStateNotifier.isAuthenticated)
                    BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.perm_identity),
                      title: const Text('Registrar'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
