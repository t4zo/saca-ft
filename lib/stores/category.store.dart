import 'package:mobx/mobx.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/repositories/category.repository.dart';
import 'package:saca/repositories/image.repository.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/category.viewmodel.dart';
import 'package:saca/view-models/image.viewmodel.dart';

part 'category.store.g.dart';

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
  List<CategoryViewModel> _categories = [];

  @computed
  List<CategoryViewModel> get categories => [..._categories];

  _CategoryStore(
      this._userStore, this._categoryRepository, this._imageRepository);

  @action
  void setCategories(List<CategoryViewModel> categories) {
    _categories = categories;
  }

  @action
  void toggleExpanded(int index, bool isExpanded) {
    List<CategoryViewModel> newCategories = categories;
    newCategories[index].isExpanded = !isExpanded;
    _categories = newCategories;
  }

  @action
  List<Image> getAllImages() {
    List<Image> images = [];
    // return _categories.map((category) => category.images);
    categories.forEach((category) {
      category.images.forEach((image) {
        images.add(image);
      });
    });

    return images;
  }

  @action
  Future<bool> addImage(ImageViewModel imageViewModel) async {
    final image =
        await _imageRepository.create(_userStore.user, imageViewModel);
    if (image == null) return false;

    final newCategories = categories;
    final category =
        newCategories.firstWhere((category) => category.id == image.categoryId);

    final index = newCategories.indexOf(category);
    if (index == -1) return false;

    newCategories[index].images.add(image);
    _categories = newCategories;

    return true;
  }

  @action
  Future<bool> updateImage(ImageViewModel image) async {
    final updatedImage = await _imageRepository.update(_userStore.user, image);
    if (updatedImage == null) return false;

    final newCategories = categories;
    final category = newCategories
        .firstWhere((category) => category.id == updatedImage.categoryId);

    final categoryIndex = newCategories.indexOf(category);
    if (categoryIndex == -1) return false;

    final _image =
        newCategories[categoryIndex].images.firstWhere((i) => i.id == image.id);
    if (_image == null) return false;

    final imageIndex = newCategories[categoryIndex].images.indexOf(_image);

    newCategories[categoryIndex].images[imageIndex] = updatedImage;

    _categories = newCategories;

    return true;
  }

  @action
  Future<bool> removeImage(Image image) async {
    final _image = await _imageRepository.remove(_userStore.user, image);
    if (_image == null) return false;

    final newCategories = categories;
    final category =
        newCategories.firstWhere((category) => category.id == image.categoryId);

    final index = newCategories.indexOf(category);
    if (index == -1) return false;

    newCategories[index].images.removeWhere((i) => i.id == image.id);
    _categories = newCategories;

    return true;
  }

  Future getAllAsync() async {
    List<Category> categories;

    if (!_userStore.isAuthenticated) {
      categories = await _categoryRepository.getAllHome();
    } else {
      categories = await _categoryRepository.getAll(_userStore.user);
    }

    final cvm = CategoryViewModel.fromCategoryList(categories);
    setCategories(cvm);
  }
}
