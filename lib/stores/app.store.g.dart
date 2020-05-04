// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$userAtom = Atom(name: '_AppStore.user');

  @override
  User get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$categoriesAtom = Atom(name: '_AppStore.categories');

  @override
  List<CategoryViewModel> get categories {
    _$categoriesAtom.context.enforceReadPolicy(_$categoriesAtom);
    _$categoriesAtom.reportObserved();
    return super.categories;
  }

  @override
  set categories(List<CategoryViewModel> value) {
    _$categoriesAtom.context.conditionallyRunInAction(() {
      super.categories = value;
      _$categoriesAtom.reportChanged();
    }, _$categoriesAtom, name: '${_$categoriesAtom.name}_set');
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setUser(User _user) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.setUser(_user);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategories(List<CategoryViewModel> categoriesVM) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.setCategories(categoriesVM);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setExpanded(int index, bool isExpanded) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.setExpanded(index, isExpanded);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isAuthenticated() {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.isAuthenticated();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'user: ${user.toString()},categories: ${categories.toString()}';
    return '{$string}';
  }
}
