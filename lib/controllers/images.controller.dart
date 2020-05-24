import 'package:saca/models/image.model.dart' as Images;
import 'package:saca/models/user.model.dart';
import 'package:saca/repositories/image.repository.dart';
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

  Future<bool> createAsync(User user, ImageViewModel imageViewModel) async {
    return await _imageRepository.create(user, imageViewModel);
  }

  Future<bool> updateAsync(User user, ImageViewModel image) async {
    return await _imageRepository.update(user, image);
  }

  Future<bool> removeAsync(User user, Images.Image image) async {
    return await _imageRepository.remove(user, image);
  }
}