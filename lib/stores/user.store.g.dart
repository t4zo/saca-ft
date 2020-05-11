// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<dynamic> _$isAuthenticatedComputed;

  @override
  dynamic get isAuthenticated => (_$isAuthenticatedComputed ??=
          Computed<dynamic>(() => super.isAuthenticated))
      .value;

  final _$userAtom = Atom(name: '_UserStore.user');

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

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setUser(User _user) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setUser(_user);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'user: ${user.toString()},isAuthenticated: ${isAuthenticated.toString()}';
    return '{$string}';
  }
}
