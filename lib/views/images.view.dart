import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/constants/services.constants.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/services/tts.service.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/widgets/create_update_image.modal.dart';

class ImagesView extends StatefulWidget {
  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
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
              return Observer(builder: (_) {
                return RefreshIndicator(
                  onRefresh: _categoryStore.getAllAsync,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: _categoryStore.images.length,
                    itemBuilder: (ctx, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onLongPress: () => _handleLongPressAsync(_categoryStore.images[i]),
                        onTap: () => _ttsService.speak(_categoryStore.images[i].name),
                        onDoubleTap: () => _showBottomSheetAsync(_categoryStore.images[i]),
                        child: GridTile(
                          child: Image.network(
                              '${ServicesConstants.CLOUDINARY_URL}/${_categoryStore.images[i].url}'),
                          footer: LayoutBuilder(
                            builder: (BuildContext context,
                                    BoxConstraints constraints) =>
                                Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                color: Colors.white,
                                width: constraints.maxWidth,
                                // decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
                                child: Text(
                                  '${_categoryStore.images[i].name}',
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
                  ),
                );
              });
            }),
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
