class Category {
  String name;
  String iconName;
  Null userCategories;
  List<Cards> cards;
  int id;

  Category(
      {this.name, this.iconName, this.userCategories, this.cards, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconName = json['iconName'];
    userCategories = json['userCategories'];
    if (json['cards'] != null) {
      cards = new List<Cards>();
      json['cards'].forEach((v) {
        cards.add(new Cards.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iconName'] = this.iconName;
    data['userCategories'] = this.userCategories;
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Cards {
  int categoryId;
  String name;
  String ext;
  String base64;
  int id;

  Cards({this.categoryId, this.name, this.ext, this.base64, this.id});

  Cards.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
    ext = json['ext'];
    base64 = json['base64'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['ext'] = this.ext;
    data['base64'] = this.base64;
    data['id'] = this.id;
    return data;
  }
}
