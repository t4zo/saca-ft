import 'package:mobx/mobx.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/view-models/category.viewmodel.dart';

part 'app.store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  User user;

  @observable
  List<CategoryViewModel> categories;

  @action
  void setUser(User _user) {
    user = _user;
  }

  @action
  void setCategories(List<CategoryViewModel> categoriesVM) {
    categories = categoriesVM;
  }

  @action setExpanded(int index, bool isExpanded) {
    categories[index].isExpanded = isExpanded;
  }

  @action
  bool isAuthenticated() {
    return user != null;
  }
}