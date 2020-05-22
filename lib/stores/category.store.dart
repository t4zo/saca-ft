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
    final _category =
        _categories.firstWhere((category) => category.id == image.categoryId);
    final _index = _categories.indexOf(_category);
    _categories[_index].images.add(image);
  }
}
