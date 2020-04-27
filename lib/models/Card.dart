class Card {
  int categoryId;
  Null category;
  String name;
  String ext;
  String base64;
  int id;

  Card({
    this.categoryId,
    this.category,
    this.name,
    this.ext,
    this.base64,
    this.id,
  });

  Card.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    category = json['category'];
    name = json['name'];
    ext = json['ext'];
    base64 = json['base64'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    data['name'] = this.name;
    data['ext'] = this.ext;
    data['base64'] = this.base64;
    data['id'] = this.id;
    return data;
  }
}
