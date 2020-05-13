import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/categories.controller.dart';
import 'package:saca/services/tts.service.dart';
import 'package:saca/settings.dart';

import 'package:saca/stores/user.store.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/views/Images/create.view.dart';

class HomeView extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ttsService = TtsService();
  final categoriesController = CategoriesController();

  @override
  void initState() {
    super.initState();
    CategoriesController().getAllAsync(context);
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => CreateImage(),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context, listen: false);
    final categoryStore = Provider.of<CategoryStore>(context, listen: false);

    return Scaffold(
      body: Observer(builder: (_) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () => categoriesController.getAllAsync(context),
            child: SingleChildScrollView(
              child: categoryStore.categories == null
                  ? Center(child: CircularProgressIndicator())
                  : ExpansionPanelList(
                      expansionCallback: (index, isExpanded) {
                        categoriesController.toggleExpanded(
                            context, index, isExpanded);
                      },
                      children: categoryStore.categories
                          .map<ExpansionPanel>(
                            (category) => ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(category.name),
                                );
                              },
                              canTapOnHeader: true,
                              isExpanded: category.isExpanded,
                              body: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: 20,
                                runSpacing: 20,
                                children: category.images.map((image) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: GestureDetector(
                                      onTap: () => ttsService.speak(image.name),
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(
                                              '$CLOUDINARY_URL/${image.url}'),
                                          Text('${image.name}')
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        );
      }),
      floatingActionButton: userStore.isAuthenticated
          ? FloatingActionButton(
              tooltip: 'Adicionar Imagem',
              onPressed: _showBottomSheet,
              // Navigator.of(context).pushNamed(CreateImage.routeName),
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryTextTheme.headline6.color,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
