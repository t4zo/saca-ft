import 'package:mobx/mobx.dart';
import 'package:saca/models/user.model.dart';

part 'user.store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User user;

  @computed
  get isAuthenticated => user != null;

  @action
  void setUser(User _user) {
    user = _user;
  }
}