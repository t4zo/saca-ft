import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/constants/application.constants.dart';
import 'package:saca/constants/services.constants.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/providers.dart';
import 'package:saca/widgets/create_update_image.modal.dart';

class ImagesView extends StatefulWidget {
  static final routeName = '/images';

  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  @override
  Widget build(BuildContext context) {
    final _ttsService = context.read(ttsProvider);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: context.read(categoryNotifier).getAllAsync(),
            builder: (ctx, snp) {
              if (snp.connectionState != ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return RefreshIndicator(
                onRefresh: context.read(categoryNotifier).getAllAsync,
                child: Consumer(builder: (context, watch, child) {
                  final _categoryNotifier = watch(categoryNotifier.state);

                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: _categoryNotifier.images.length,
                    itemBuilder: (ctx, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onLongPress: () => _handleLongPressAsync(_categoryNotifier.images[i]),
                        onTap: () => _ttsService.speak(_categoryNotifier.images[i].name),
                        onDoubleTap: () => _showBottomSheetAsync(_categoryNotifier.images[i]),
                        child: GridTile(
                          child: Image.network('${ServicesConstants.CLOUDINARY_URL}/${_categoryNotifier.images[i].url}'),
                          footer: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                color: Colors.white,
                                width: constraints.maxWidth,
                                // decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
                                child: Text(
                                  '${_categoryNotifier.images[i].name}',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
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
      builder: (ctx) => image != null ? CreateUpdateImage(image: image) : CreateUpdateImage(),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
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
                TextButton(
                  child: Text(
                    'Voltar',
                    style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                    child: const Text(
                      'Remover',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      await context.read(categoryNotifier).removeImageAsync(image);
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }
}
