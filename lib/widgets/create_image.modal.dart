import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';
import 'package:saca/controllers/images.controller.dart';
import 'package:saca/settings.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/image.viewmodel.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:uuid/uuid.dart';

class CreateImage extends StatefulWidget {
  static const routeName = '/images/create';
  Images.Image image;

  CreateImage({this.image});

  @override
  _CreateImageState createState() => _CreateImageState();
}

class _CreateImageState extends State<CreateImage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _form = GlobalKey<FormState>();

  File _image;

  bool _keyboardVisible = false;

  bool _loading = false;

  var _model =  ImageViewModel();

  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    KeyboardVisibility.onChange.listen((visible) {
      _keyboardVisible = visible;
    });

    if (widget.image != null) {
      syspaths.getApplicationDocumentsDirectory().then((tempDir) {
        final localDirectoryPath = '${tempDir.path}/tempDirectory';
        final localImagePath = '$localDirectoryPath/image-${Uuid().v4()}.jpg';

        final localDirectory = Directory(localDirectoryPath);
        final localFile = File(localImagePath);

        if (localDirectory.existsSync()) {
          localDirectory.deleteSync(recursive: true);
        }

        localDirectory.createSync();

        Dio()
            .download('$CLOUDINARY_URL/${widget.image.url}', localImagePath)
            .then((response) {
          setState(() {
            _nameController.text = widget.image.name;
            _model.name = widget.image.name;
            _image = localFile;
          });
        });
      });
    }
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

  Future _handleSave() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;

    if (_image == null) return;

    _form.currentState.save();

    final user = Provider.of<UserStore>(context, listen: false).user;

    final imageBytes = await _image.readAsBytes();
    setState(() {
      _model.categoryId = 1;
      _model.base64 = base64Encode(imageBytes);
      _loading = true;
    });

    final result = await ImagesController().create(context, user, _model);

    setState(() {
      _loading = false;
    });

    if (result) {
      Navigator.of(context).pop();
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Erro ao enviar imagem'),
        duration: Duration(seconds: 5),
      ));
    }
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
            Text(
              'Aperte no quadrado para capturar a imagem',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: _image == null ? Colors.red : Colors.green,
                decorationThickness: 3,
              ),
            ),
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
                            ? Icon(
                                Icons.camera_alt,
                                color: Theme.of(context).primaryColor,
                              )
                            : Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Form(
                      key: _form,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.done,
                          autocorrect: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Nome da Imagem',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'Informe um nome';
                            return null;
                          },
                          onSaved: (value) => _model.name = value,
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
                icon: Icon(Icons.add, color: Colors.white),
                label: _loading
                    ? SizedBox(
                        height: 10,
                        child: const CircularProgressIndicator(strokeWidth: 3),
                      )
                    : const Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                color: Theme.of(context).primaryColor,
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: _handleSave,
              ),
            )
          ],
        ),
      ),
    );
  }
}
