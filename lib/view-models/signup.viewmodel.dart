class SignUpViewModel {
  String username;
  String email;
  String password;
  String confirmPassword;
  List<String> roles;

  SignUpViewModel({
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
    this.roles,
  });

  SignUpViewModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['roles'] = this.roles;
    return data;
  }
}
