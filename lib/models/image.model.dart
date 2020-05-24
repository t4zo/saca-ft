class Image {
  int id = 0;
  int categoryId = 0;
  int userId = 0;
  String name = '';
  String url = '';

  Image({
    this.id,
    this.categoryId,
    this.userId,
    this.name,
    this.url,
  });

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    userId = json['userId'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
