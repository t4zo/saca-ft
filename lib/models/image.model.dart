class Image {
  int categoryId;
  Null category;
  int userId;
  Null user;
  String name;
  String url;
  String ext;
  int id;

  Image({
    this.categoryId,
    this.category,
    this.userId,
    this.user,
    this.name,
    this.url,
    this.ext,
    this.id,
  });

  Image.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    category = json['category'];
    userId = json['userId'];
    user = json['user'];
    name = json['name'];
    url = json['url'];
    ext = json['ext'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    data['userId'] = this.userId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['url'] = this.url;
    data['ext'] = this.ext;
    data['id'] = this.id;
    return data;
  }
}
