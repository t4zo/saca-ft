import 'package:saca/models/category.model.dart';
import 'package:saca/models/image.model.dart';

class CategoryViewModel {
  int id;
  String name;
  List<Image> images;
  bool isExpanded;

  CategoryViewModel.fromCategory(Category category) {
    this.id = category.id;
    this.name = category.name;
    this.images = category.images;
    this.isExpanded = true;
  }
}