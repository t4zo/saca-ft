import 'package:flutter/material.dart';
import 'package:saca/controllers/images.controller.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/services/tts.service.dart';
import 'package:saca/settings.dart';

class ImagesView extends StatefulWidget {
  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  final _ttsService = TtsService();
  List<Images.Image> _images;

  @override
  void initState() {
    super.initState();
    setState(() {
      _images = ImagesController().getAll(context);
    });
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
                    onTap: () => _ttsService.speak(_images[i].name),
                    child: GridTile(
                      footer: Container(
                        // backgroundColor: Colors.grey,
                        child: Text(
                          '${_images[i].name}',
                          style: TextStyle(color: Colors.white, backgroundColor: Colors.grey),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                      child: Image.network('$CLOUDINARY_URL/${_images[i].url}'),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
