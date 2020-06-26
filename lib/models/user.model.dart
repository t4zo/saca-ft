class User {
  int id;
  String username;
  String email;
  List<String> roles;
  String token;

  User({this.id, this.username, this.email, this.roles, this.token});

  bool isAuthenticated() {
    return this.token.isEmpty;
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roles = json['roles'].cast<String>();
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['roles'] = this.roles;
    data['token'] = this.token;
    return data;
  }

  @override
  String toString() {
    return this.email;
  }
}
