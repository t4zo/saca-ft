import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/images.controller.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/controllers/categories.controller.dart';
import 'package:saca/services/tts.service.dart';
import 'package:saca/settings.dart';

import 'package:saca/stores/user.store.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/widgets/create_update_image.modal.dart';

class CategoriesView extends StatefulWidget {
  static final routeName = '/categories';

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final _ttsService = TtsService();
  final _categoriesController = CategoriesController();
  final _imagesController = ImagesController();

  void _showBottomSheet([Images.Image image]) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>
          image != null ? CreateUpdateImage(image: image) : CreateUpdateImage(),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    );
  }

  Future _handleLongPress(Images.Image image) async {
    if (image.categoryId != 1) return;

    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Remover Imagem'),
              content: Text('Tem certeza que deseja remover `${image.name}`?'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: const Text(
                      'Remover',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      await _imagesController.removeAsync(
                        Provider.of<CategoryStore>(context, listen: false),
                        Provider.of<UserStore>(context, listen: false).user,
                        image,
                      );
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final _userStore = Provider.of<UserStore>(context, listen: false);
    final _categoryStore = Provider.of<CategoryStore>(context, listen: false);

    return Scaffold(
      body: Observer(
        builder: (_) => SafeArea(
          child: FutureBuilder(
            future:
                _categoriesController.getAllAsync(_userStore, _categoryStore),
            builder: (ctx, snp) {
              if (snp.connectionState != ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return Observer(
                builder: (_) => RefreshIndicator(
                  onRefresh: () => _categoriesController.getAllAsync(
                      _userStore, _categoryStore),
                  child: SingleChildScrollView(
                    child: ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.all(0),
                      expansionCallback: (index, isExpanded) {
                        _categoriesController.toggleExpanded(
                            _categoryStore, index, isExpanded);
                      },
                      children: _categoryStore.categories
                          .map<ExpansionPanel>(
                            (category) => ExpansionPanel(
                              headerBuilder: (context, isExpanded) => ListTile(
                                title: Text(category.name),
                              ),
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
                                      onLongPress: () =>
                                          _handleLongPress(image),
                                      onTap: () =>
                                          _ttsService.speak(image.name),
                                      onDoubleTap: () =>
                                          _showBottomSheet(image),
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
            },
          ),
        ),
      ),
      floatingActionButton: _userStore.isAuthenticated
          ? FloatingActionButton(
              tooltip: 'Adicionar Imagem',
              onPressed: _showBottomSheet,
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
