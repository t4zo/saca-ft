class SignInViewModel {
  String email;
  String password;
  bool remember = false;
  bool busy = false;

  SignInViewModel({this.email, this.password, this.remember, this.busy});

  SignInViewModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    remember = json['remember'];
    busy = json['remember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['remember'] = this.remember;
    data['busy'] = this.busy;
    return data;
  }
}
