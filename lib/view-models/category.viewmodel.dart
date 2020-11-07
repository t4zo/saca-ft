import 'package:saca/models/category.model.dart';
import 'package:saca/models/image.model.dart';

class CategoryViewModel {
  int id;
  String name;
  List<Image> images;
  bool isExpanded;

  CategoryViewModel({this.id, this.name, this.images, this.isExpanded});

  CategoryViewModel.empty() {
    this.id = 0;
    this.name = '';
    this.images = [Image()];
    this.isExpanded = false;
  }
  
  CategoryViewModel.fromCategory(Category category) {
    this.id = category.id;
    this.name = category.name;
    this.images = category.images;
    this.isExpanded = false;
  }

  static Iterable<CategoryViewModel> fromCategoryList(List<Category> categories) {
    return categories.map((category) => CategoryViewModel.fromCategory(category));
  }
}
