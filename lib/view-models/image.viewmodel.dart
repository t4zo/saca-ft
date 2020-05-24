class ImageViewModel {
  int id = 0;
  int categoryId = 0;
  String name = "";
  String base64 = "";

  ImageViewModel({this.id, this.name, this.categoryId, this.base64});

  ImageViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    base64 = json['base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['base64'] = this.base64;
    return data;
  }
}
