import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/constants/services.constants.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/services/tts.service.dart';

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

  @override
  Widget build(BuildContext context) {
    final _userStore = Provider.of<UserStore>(context, listen: false);
    final _categoryStore = Provider.of<CategoryStore>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _categoryStore.getAllAsync(),
          builder: (ctx, snp) {
            if (snp.connectionState != ConnectionState.done) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Observer(
              builder: (_) => RefreshIndicator(
                onRefresh: _categoryStore.getAllAsync,
                child: SingleChildScrollView(
                  child: ExpansionPanelList(
                    expandedHeaderPadding: const EdgeInsets.all(0),
                    expansionCallback: (index, isExpanded) {
                      _categoryStore.toggleExpanded(index, isExpanded);
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: GestureDetector(
                                    onLongPress: () =>
                                        _handleLongPressAsync(image),
                                    onTap: () => _ttsService.speak(image.name),
                                    onDoubleTap: () =>
                                        _showBottomSheetAsync(image),
                                    child: Column(
                                      children: <Widget>[
                                        Image.network(
                                            '${ServicesConstants.CLOUDINARY_URL}/${image.fullyQualifiedPublicUrl}'),
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
      floatingActionButton: _userStore.isAuthenticated
          ? FloatingActionButton(
              tooltip: 'Adicionar Imagem',
              onPressed: _showBottomSheetAsync,
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

  Future _showBottomSheetAsync([Images.Image image]) async {
    if (image != null && image.categoryId != 1) return;

    return showModalBottomSheet(
      context: context,
      builder: (ctx) =>
          image != null ? CreateUpdateImage(image: image) : CreateUpdateImage(),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    );
  }

  Future _handleLongPressAsync(Images.Image image) async {
    if (image.categoryId != 1) return;

    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Remover Imagem'),
              content: Text('Tem certeza que deseja remover ${image.name}?'),
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
                      await Provider.of<CategoryStore>(context, listen: false)
                          .removeImageAsync(image);
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }
}
