import 'package:saca/models/image.model.dart';

class Category {
  String name = '';
  String iconName = '';
  Null userCategories;
  List<Image> images = [Image()];
  int id = 0;

  Category({
    this.name,
    this.iconName,
    this.userCategories,
    this.images,
    this.id,
  });

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconName = json['iconName'];
    userCategories = json['userCategories'];
    if (json['images'] != null) {
      images = new List<Image>();
      json['images'].forEach((v) {
        images.add(new Image.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iconName'] = this.iconName;
    data['userCategories'] = this.userCategories;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
