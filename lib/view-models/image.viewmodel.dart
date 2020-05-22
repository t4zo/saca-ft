class ImageViewModel {
  String name = "";
  int categoryId = 0;
  String base64 = "";

  ImageViewModel({this.name, this.categoryId, this.base64});

  ImageViewModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['categoryId'];
    base64 = json['base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['base64'] = this.base64;
    return data;
  }
}
