import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class CreateImage extends StatefulWidget {
  static const routeName = '/images/create';

  @override
  _CreateImageState createState() => _CreateImageState();
}

class _CreateImageState extends State<CreateImage> {
  File _image;
  final _imageNameController = TextEditingController();
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibility.onChange.listen((visible) {
      _keyboardVisible = visible;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _takePicture() async {
    final image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
    );

    if (image == null) return Future.value();

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);

    final savedImage = await image.copy('${appDir.path}/$fileName');

    setState(() {
      _image = savedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        height:
            MediaQuery.of(context).size.height * (_keyboardVisible ? 0.7 : 0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text('Aperte na imagem para capturá-la'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor)),
                        alignment: Alignment.center,
                        child: _image == null
                            ? Icon(Icons.camera_alt, color: Theme.of(context).primaryColor,)
                            : Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _imageNameController,
                        autocorrect: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Nome da Imagem',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton.icon(
                icon: Icon(Icons.add),
                label: const Text('Salvar'),
                color: Theme.of(context).accentColor,
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: _takePicture,
              ),
            )
          ],
        ),
      ),
    );
  }
}
