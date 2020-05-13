import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/stores/category.store.dart';

class ImagesController {
  List<Images.Image> getAll(BuildContext context) {
    final _categories = Provider.of<CategoryStore>(context, listen: false).categories;
    List<Images.Image> _images = [];
    // final _images = _categories.map((category) => category.images.map((image) => {image}).toList()).toList();
    _categories.forEach((category) {
      category.images.forEach((image) {
        _images.add(image);
      });
    });

    return _images;
  }
}