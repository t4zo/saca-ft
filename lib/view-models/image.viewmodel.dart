class ImageViewModel {
  int id;
  int categoryId;
  String name;
  String base64;

  ImageViewModel({this.id, this.name, this.categoryId, this.base64});

  ImageViewModel.empty() {
    this.id = 0;
    this.categoryId = 0;
    this.name = '';
    this.base64 = '';
  }

  ImageViewModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.categoryId = json['categoryId'];
    this.name = json['name'];
    this.base64 = json['base64'];
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
