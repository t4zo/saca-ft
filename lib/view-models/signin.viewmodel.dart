class SignInViewModel {
  String email;
  String password;
  bool remember;
  bool busy;

  SignInViewModel({this.email, this.password, this.remember, this.busy});

  SignInViewModel.empty(Map<String, dynamic> json) {
    this.email = '';
    this.password = '';
    this.remember = false;
    this.busy = false;
  }

  SignInViewModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.password = json['password'];
    this.remember = json['remember'];
    this.busy = json['remember'];
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
