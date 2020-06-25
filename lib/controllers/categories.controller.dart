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

  Future getAllAsync(UserStore userStore, CategoryStore categoryStore) async {
    List<Category> categories;

    if (!userStore.isAuthenticated) {
      categories = await _categoryRepository.getAllHome();
    } else {
      categories = await _categoryRepository.getAll(userStore.user);
    }

    final cvm = CategoryViewModel().fromCategoryList(categories);
    categoryStore.setCategories(cvm);
  }

  void toggleExpanded(CategoryStore categoryStore, int index, bool isExpanded) {
    categoryStore.toggleExpanded(index, isExpanded);
  }
}
