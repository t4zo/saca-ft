import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/constants/application.constants.dart';
import 'package:saca/constants/services.constants.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/providers.dart';

import 'package:saca/widgets/create_update_image.modal.dart';

class CategoriesView extends StatefulWidget {
  static final routeName = '/categories';

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
  final _ttsService = context.read(ttsProvider);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: context.read(categoryNotifier).getAllAsync(),
            builder: (BuildContext ctx, snp) {
              if (snp.connectionState != ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return RefreshIndicator(
                  onRefresh: context.read(categoryNotifier).getAllAsync,
                  child: SingleChildScrollView(
                    child: Consumer(builder: (context, watch, child) {
                      final _categoryState = watch(categoryNotifier.state);
                      return ExpansionPanelList(
                        expandedHeaderPadding: const EdgeInsets.all(0),
                        expansionCallback: (index, isExpanded) => context
                            .read(categoryNotifier)
                            .toggleExpanded(index, isExpanded),
                        children: _categoryState.categoriesViewModel
                            .map<ExpansionPanel>(
                              (category) => ExpansionPanel(
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(title: Text(category.name)),
                                canTapOnHeader: true,
                                isExpanded: category.isExpanded,
                                body: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.spaceEvenly,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: category.images
                                      .map(
                                        (image) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: GestureDetector(
                                            onLongPress: () =>
                                                _handleLongPressAsync(image),
                                            onTap: () =>
                                                _ttsService.speak(image.name),
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
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ));
            }),
      ),
      floatingActionButton: context.read(userStateNotifier).isAuthenticated()
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
    if (image != null && image.categoryId != ApplicationConstants.categorialPessoalId) return;

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
    if (image.categoryId != ApplicationConstants.categorialPessoalId) return;

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
                      await context
                          .read(categoryNotifier)
                          .removeImageAsync(image);
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }
}
