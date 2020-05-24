import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/images.controller.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/services/tts.service.dart';
import 'package:saca/settings.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/stores/user.store.dart';

class ImagesView extends StatefulWidget {
  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  final _ttsService = TtsService();
  final _imagesController = ImagesController();
  List<Images.Image> _images;

  @override
  void initState() {
    super.initState();
    setState(() {
      _images = _imagesController.getAll(Provider.of<CategoryStore>(context, listen: false).categories);
    });
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
    return Scaffold(
      body: SafeArea(
        child: _images == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 1,
                ),
                itemCount: _images.length,
                itemBuilder: (ctx, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onLongPress: () => _handleLongPress(_images[i]),
                    onTap: () => _ttsService.speak(_images[i].name),
                    child: GridTile(
                      child: Image.network('$CLOUDINARY_URL/${_images[i].url}'),
                      footer: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '${_images[i].name}',
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                          ),
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
  }
}
