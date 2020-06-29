import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';
import 'package:saca/settings.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/view-models/image.viewmodel.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:uuid/uuid.dart';

class CreateUpdateImage extends StatefulWidget {
  static const routeName = '/images/create';

  final Images.Image image;

  CreateUpdateImage({this.image});

  @override
  _CreateUpdateImageState createState() => _CreateUpdateImageState();
}

class _CreateUpdateImageState extends State<CreateUpdateImage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File _image;

  bool _keyboardVisible = false;
  bool _loading = false;
  bool _isUpdate = false;

  var _model = ImageViewModel();

  @override
  void initState() {
    super.initState();
    KeyboardVisibility.onChange.listen((visible) {
      _keyboardVisible = visible;
    });

    if (widget.image != null) {
      _handleInitialFileConfiguration();
    }
  }

  void _handleInitialFileConfiguration() async {
    final tempDir = await syspaths.getTemporaryDirectory();
    final localDirectoryPath = '${tempDir.path}/tempDirectory';
    final localImagePath = '$localDirectoryPath/${Uuid().v4()}.jpg';

    resetDirectory(localDirectoryPath);
    downloadFile(localImagePath);
  }

  void downloadFile(String localImagePath) async {
    final localFile = File(localImagePath);

    final response = await Dio()
        .download('$CLOUDINARY_URL/${widget.image.url}', localImagePath);

    if (response.statusCode != 200) return;

    setState(() {
      _isUpdate = true;
      _nameController.text = widget.image.name;
      _model.name = widget.image.name;
      _image = localFile;
    });
  }

  void resetDirectory(localDirectoryPath) {
    final localDirectory = Directory(localDirectoryPath);
    if (localDirectory.existsSync()) {
      localDirectory.deleteSync(recursive: true);
    }
    localDirectory.createSync();
  }

  Future _handlePicture() async {
    final imageSource = await _chooseCaptureMethod();
    final image = await _takePicture(imageSource);
    if (image != null) {
      await _saveLocalPicture(image);
    }
  }

  Future<ImageSource> _chooseCaptureMethod() async {
    return await showDialog<ImageSource>(
        context: context,
        builder: (_) {
          return SimpleDialog(
            title: Text('Escolha o modo',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline6.fontSize)),
            children: <Widget>[
              SimpleDialogOption(
                child: const Text('Galeria', style: TextStyle(fontSize: 16)),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              SimpleDialogOption(
                child: const Text('Câmera', style: TextStyle(fontSize: 16)),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          );
        });
  }

  Future _takePicture(ImageSource imageSource) async {
    return await ImagePicker.pickImage(
      source: imageSource,
      maxHeight: 200,
    );
  }

  Future _saveLocalPicture(File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);

    final savedImage = await image.copy('${appDir.path}/$fileName');

    setState(() {
      _image = savedImage;
    });
  }

  Future _handleSaveOrUpdate() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;

    if (_image == null) return;

    _form.currentState.save();

    final categoryStore = Provider.of<CategoryStore>(context, listen: false);

    final imageBytes = await _image.readAsBytes();

    setState(() {
      _model.categoryId = 1;
      _model.base64 = base64Encode(imageBytes);
      _loading = true;
    });

    bool result;
    if (_isUpdate) {
      result = await categoryStore.updateImage(ImageViewModel(
        id: widget.image.id,
        categoryId: _model.categoryId,
        name: _model.name,
        base64: _model.base64,
      ));
    } else {
      result = await categoryStore.addImage(_model);
    }

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
                      onTap: _handlePicture,
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
              child: SizedBox(
                height: 40,
                child: RaisedButton(
                  child: _loading
                      ? SizedBox(
                          height: 10,
                          child:
                              const CircularProgressIndicator(strokeWidth: 3),
                        )
                      : Text(
                          _isUpdate ? 'Atualizar' : 'Salvar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                  color: Theme.of(context).primaryColor,
                  elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: _handleSaveOrUpdate,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
