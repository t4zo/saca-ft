import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/repositories/category.repository.dart';
import 'package:saca/repositories/image.repository.dart';
import 'package:saca/notifiers/user.notifier.dart';
import 'package:saca/view-models/category.viewmodel.dart';
import 'package:saca/view-models/image.viewmodel.dart';

class ImageStoreResponse {
  bool response;
  String errorMessage;

  ImageStoreResponse({this.response, this.errorMessage});
}

class CategoryState {
  List<CategoryViewModel> categoriesViewModel;

  List<Image> get images {
    // List<Image> imgs = [];
    // categories.forEach((category) => imgs.addAll(category.images));
    // return imgs;

    return categoriesViewModel.expand((category) => category.images).toList();
  }

  CategoryState(this.categoriesViewModel);

  CategoryState.empty() {
    this.categoriesViewModel = null;
  }
}

class CategoryStateNotifier extends StateNotifier<CategoryState> {
  final UserStateNotifier _userStateNotifier;
  final CategoryRepository _categoryRepository;
  final ImageRepository _imageRepository;

  CategoryStateNotifier(this._userStateNotifier, this._categoryRepository, this._imageRepository, [List<CategoryViewModel> categoriesViewModel])
      : super(CategoryState(categoriesViewModel ?? List<CategoryViewModel>.empty()));

  List<Image> images() => state.images;

  void toggleExpanded(int index, bool isExpanded) {
    final _categoriesViewModel = state.categoriesViewModel;
    _categoriesViewModel[index].isExpanded = !isExpanded;
    state = CategoryState(_categoriesViewModel);
  }

  Future<String> getAllAsync() async {
    final http = await _categoryRepository.getAllAsync(_userStateNotifier.state.user);
    if (http.error != null) return http.errorMessage;

    final categories = http.response;
    final categoriesViewModel = CategoryViewModel.fromCategoryList(categories).toList();
    state = CategoryState(categoriesViewModel);

    return "";
  }

  Future<String> addImageAsync(ImageViewModel imageViewModel) async {
    final http = await _imageRepository.createAsync(_userStateNotifier.state.user, imageViewModel);
    if (http.error != null) return http.errorMessage;

    return await getAllAsync();

    // Without fetching all images again
    // final image = http.response;

    // // final newCategories = categories;
    // // // final category =
    // // //     newCategories.firstWhere((category) => category.id == image.categoryId);

    // // // final index = newCategories.indexOf(category);
    // // // newCategories[index].images = [...newCategories[index].images, image];

    // // // _categories = newCategories;

    // return "";
  }

  Future<String> updateImageAsync(ImageViewModel image) async {
    final http = await _imageRepository.updateAsync(_userStateNotifier.state.user, image);
    if (http.error != null) return http.errorMessage;

    return await getAllAsync();

    // Without fetching all images again
    // final updatedImage = http.response;

    // final newCategories = categories;
    // final category = newCategories
    //     .firstWhere((category) => category.id == updatedImage.categoryId);

    // final categoryIndex = newCategories.indexOf(category);
    // if (categoryIndex == -1) return "Categoria não encontrada";

    // final _image =
    //     newCategories[categoryIndex].images.firstWhere((i) => i.id == image.id);

    // final imageIndex = newCategories[categoryIndex].images.indexOf(_image);

    // newCategories[categoryIndex].images[imageIndex] = updatedImage;

    // _categories = newCategories;

    // return "";
  }

  Future<String> removeImageAsync(Image image) async {
    final http = await _imageRepository.removeAsync(_userStateNotifier.state.user, image);
    if (http.error != null) return http.errorMessage;

    return await getAllAsync();

    // Without fetching all images again
    // final newCategories = categories;
    // final category =
    //     newCategories.firstWhere((category) => category.id == image.categoryId);

    // final index = newCategories.indexOf(category);
    // if (index == -1) return "Categoria não encontrada";

    // newCategories[index].images.removeWhere((i) => i.id == image.id);

    // _categories = newCategories;

    // return "";
  }
}
