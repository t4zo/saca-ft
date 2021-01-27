import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/models/user.model.dart';

class UserState {
  User user;

  bool get isAuthenticated => user != null;

  UserState(this.user);

  UserState.empty() {
    this.user = null;
  }
}

class UserStateNotifier extends StateNotifier<UserState> {
  UserStateNotifier() : super(UserState.empty());

  bool isAuthenticated() => state.isAuthenticated;

  void setUser(User user) {
    state = UserState(user);
  }
}