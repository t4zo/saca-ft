import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/repositories/category.repository.dart';
import 'package:saca/stores/category.store.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/category.viewmodel.dart';

class CategoriesController {
  CategoryRepository _categoryRepository;

  CategoriesController() {
    _categoryRepository = CategoryRepository();
  }

  List<CategoryViewModel> categories(BuildContext context) {
    final _categoryStore = Provider.of<CategoryStore>(context, listen: false);
    return _categoryStore.categories;
  }

  Future<void> getAllAsync(BuildContext context) async {
    final _userStore = Provider.of<UserStore>(context, listen: false);
    final _categoryStore = Provider.of<CategoryStore>(context, listen: false);
    List<Category> categories;

    if (!_userStore.isAuthenticated) {
      categories = await _categoryRepository.getAllHome();
    } else {
      categories = await _categoryRepository.getAll(_userStore.user);
    }

    final cvm = CategoryViewModel().fromCategoryList(categories);
    _categoryStore.setCategories(cvm);
  }

  void toggleExpanded(BuildContext context, int index, bool isExpanded) {
    Provider.of<CategoryStore>(context, listen: false)
        .toggleExpanded(index, isExpanded);
  }
}
