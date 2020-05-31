import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/models/user.model.dart';
import 'package:saca/repositories/image.repository.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/view-models/image.viewmodel.dart';

class ImagesController {
  ImageRepository _imageRepository;

  ImagesController() {
    _imageRepository = ImageRepository();
  }

  List<Images.Image> getAll(categories) {
    List<Images.Image> images = [];
    // final _images = _categories.map((category) => category.images.map((image) => {image}).toList()).toList();
    categories.forEach((category) {
      category.images.forEach((image) {
        images.add(image);
      });
    });

    return images;
  }

  Future<bool> createAsync(CategoryStore categoryStore, User user, ImageViewModel imageViewModel) async {
    final _image = await _imageRepository.create(user, imageViewModel);
    if(_image == null) return false;

    categoryStore.addImage(_image);
    return true;
  }

  Future<bool> updateAsync(CategoryStore categoryStore, User user, ImageViewModel image) async {
    final _image = await _imageRepository.update(user, image);
    if(_image == null) return false;

    categoryStore.updateImage(_image);
    return true;
  }

  Future<bool> removeAsync(CategoryStore categoryStore, User user, Images.Image image) async {
    final _image = await _imageRepository.remove(user, image);
    if(_image == null) return false;

    categoryStore.removeImage(_image);
    return true;
  }
}