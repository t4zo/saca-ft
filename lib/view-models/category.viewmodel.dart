import 'package:saca/models/category.model.dart';
import 'package:saca/models/image.model.dart';

class CategoryViewModel {
  int id = 0;
  String name = '';
  List<Image> images = [Image()];
  bool isExpanded = false;

  CategoryViewModel({this.id, this.name, this.images, this.isExpanded});

  CategoryViewModel.fromCategory(Category category) {
    this.id = category.id;
    this.name = category.name;
    this.images = category.images;
    this.isExpanded = false;
  }

  static List<CategoryViewModel> fromCategoryList(List<Category> categories) {
    var cvm = new List<CategoryViewModel>();

    categories.forEach((c) {
      cvm.add(CategoryViewModel.fromCategory(c));
    });

    return cvm;
  }
}
