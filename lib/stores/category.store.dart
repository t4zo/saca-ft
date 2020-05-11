import 'package:mobx/mobx.dart';
import 'package:saca/view-models/category.viewmodel.dart';

part 'category.store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  @observable
  List<CategoryViewModel> _categories;

  @computed
  List<CategoryViewModel> get categories {
    return _categories == null ? [] : [..._categories];
  }

  @action
  void setCategories(List<CategoryViewModel> categories) {
    _categories = categories;
  }

  @action
  void toggleExpanded(int index, bool isExpanded) {
    List<CategoryViewModel> categories = List.from(_categories);
    print(categories[index].isExpanded);
    categories[index].isExpanded = !isExpanded;
    print(categories[index].isExpanded);
    _categories = categories;
  }
}