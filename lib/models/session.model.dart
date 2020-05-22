import 'dart:async';

class SessionViewModel {
  int id;
  String token;
  DateTime expiryDate;
  Timer authTimer;

  SessionViewModel({this.id, this.token, this.expiryDate, this.authTimer});

  SessionViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    expiryDate = json['expiryDate'];
    authTimer = json['authTimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['expiryDate'] = this.expiryDate;
    data['authTimer'] = this.authTimer;
    return data;
  }
}
