import 'package:mobx/mobx.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/view-models/category.viewmodel.dart';

part 'category.store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  @observable
  List<CategoryViewModel> _categories = [];

  List<CategoryViewModel> get categories => [..._categories];

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
  void addImage(Image image) {
    final newCategories = categories;
    final category = newCategories.firstWhere((category) => category.id == image.categoryId);
    
    final index = newCategories.indexOf(category);
    if(index == -1) return;
    
    newCategories[index].images.add(image);
    _categories = newCategories;
  }

  @action
  void updateImage(Image image) {
    final newCategories = categories;
    final category = newCategories.firstWhere((category) => category.id == image.categoryId);
    
    final categoryIndex = newCategories.indexOf(category);
    if(categoryIndex == -1) return;

    final _image = newCategories[categoryIndex].images.firstWhere((i) => i.id == image.id);

    if(_image == null) return;

    final imageIndex = newCategories[categoryIndex].images.indexOf(_image);

    newCategories[categoryIndex].images[imageIndex] = image;

    _categories = newCategories;
  }

  @action
  void removeImage(Image image) {
    final newCategories = categories;
    final category = newCategories.firstWhere((category) => category.id == image.categoryId);

    final index = newCategories.indexOf(category);
    if(index == -1) return;

    newCategories[index].images.removeWhere((i) => i.id == image.id);
    _categories = newCategories;
  }
}
