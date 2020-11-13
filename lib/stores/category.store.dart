import 'package:mobx/mobx.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/repositories/category.repository.dart';
import 'package:saca/repositories/image.repository.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/category.viewmodel.dart';
import 'package:saca/view-models/image.viewmodel.dart';

part 'category.store.g.dart';

class ImageStoreResponse {
  bool response;
  String errorMessage;

  ImageStoreResponse({this.response, this.errorMessage});
}

class CategoryStore extends _CategoryStore with _$CategoryStore {
  CategoryStore(UserStore userStore, CategoryRepository categoryRepository,
      ImageRepository imageRepository)
      : super(userStore, categoryRepository, imageRepository);
}

abstract class _CategoryStore with Store {
  final UserStore _userStore;
  final CategoryRepository _categoryRepository;
  final ImageRepository _imageRepository;

  @observable
  Iterable<CategoryViewModel> _categories = [];

  _CategoryStore(
      this._userStore, this._categoryRepository, this._imageRepository);

  @computed
  List<CategoryViewModel> get categories => [..._categories];

  @computed
  List<Image> get images {
    List<Image> imgs = [];
    // return _categories.map((category) => category.images);

    categories.forEach((category) {
      category.images.forEach((img) {
        imgs.add(img);
      });
    });

    return imgs;
  }

  @action
  void toggleExpanded(int index, bool isExpanded) {
    List<CategoryViewModel> newCategories = categories;
    newCategories[index].isExpanded = !isExpanded;
    _categories = newCategories;
  }

  @action
  Future<String> getAllAsync() async {
    final http = await _categoryRepository.getAllAsync(_userStore.user);
    if (http.error != null) return http.errorMessage;

    final categories = http.response;
    _categories = CategoryViewModel.fromCategoryList(categories).toList();

    return "";
  }

  @action
  Future<String> addImageAsync(ImageViewModel imageViewModel) async {
    final http =
        await _imageRepository.createAsync(_userStore.user, imageViewModel);
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

  @action
  Future<String> updateImageAsync(ImageViewModel image) async {
    final http = await _imageRepository.updateAsync(_userStore.user, image);
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

  @action
  Future<String> removeImageAsync(Image image) async {
    final http = await _imageRepository.removeAsync(_userStore.user, image);
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
