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
    List<CategoryViewModel> categories = List.from(_categories);
    categories[index].isExpanded = !isExpanded;
    _categories = categories;
  }

  @action
  void addImage(Image image) {
    final category =
        _categories.firstWhere((category) => category.id == image.categoryId);
    
    final index = _categories.indexOf(category);
    if(index == -1) return;
    
    _categories[index].images.add(image);
  }

  @action
  void updateImage(Image image) {
    final category =
        _categories.firstWhere((category) => category.id == image.categoryId);
    
    final categoryIndex = _categories.indexOf(category);
    if(categoryIndex == -1) return;

    final _image = _categories[categoryIndex].images.firstWhere((i) => i.id == image.id);

    if(_image == null) return;

    final imageIndex = _categories[categoryIndex].images.indexOf(_image);

    _categories[categoryIndex].images[imageIndex] = image;
  }

  @action
  void removeImage(Image image) {
    List<CategoryViewModel> categories = List.from(_categories);

    final category =
        categories.firstWhere((category) => category.id == image.categoryId);

    final index = _categories.indexOf(category);
    if(index == -1) return;

    categories[index].images.remove(image);

    _categories = categories;
  }
}
