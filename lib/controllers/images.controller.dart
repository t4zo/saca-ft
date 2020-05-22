import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/models/user.model.dart';
import 'package:saca/repositories/image.repository.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/image.viewmodel.dart';

class ImagesController {
  ImageRepository _imageRepository;

  ImagesController() {
    _imageRepository = ImageRepository();
  }

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

  Future<bool> create(BuildContext context, User user, ImageViewModel image) async {
    return await _imageRepository.create(user, image);
  }

  Future<bool> remove(BuildContext context, User user, Images.Image image) async {
    final user = Provider.of<UserStore>(context, listen: false).user;
    return await _imageRepository.remove(user, image);
  }
}