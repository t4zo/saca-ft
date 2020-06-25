class Image {
  int id = 0;
  int categoryId = 0;
  int userId = 0;
  String name = '';
  String url = '';
  String fullyQualifiedPublicUrl = '';

  Image({
    this.id,
    this.categoryId,
    this.userId,
    this.name,
    this.url,
    this.fullyQualifiedPublicUrl,
  });

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    userId = json['userId'];
    name = json['name'];
    url = json['url'];
    fullyQualifiedPublicUrl = json['fullyQualifiedPublicUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['url'] = this.url;
    data['fullyQualifiedPublicUrl'] = this.fullyQualifiedPublicUrl;
    return data;
  }

  @override
  String toString() {
    return this.name;
  }
}
