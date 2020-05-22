import 'package:mobx/mobx.dart';
import 'package:saca/models/user.model.dart';

part 'user.store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User _user;

  @computed
  get isAuthenticated => _user != null;

  @computed
  get user => _user;

  @action
  void setUser(User user) {
    _user = user;
  }
}