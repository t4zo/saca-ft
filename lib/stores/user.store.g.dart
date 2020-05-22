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
  Computed<dynamic> _$userComputed;

  @override
  dynamic get user =>
      (_$userComputed ??= Computed<dynamic>(() => super.user)).value;

  final _$_userAtom = Atom(name: '_UserStore._user');

  @override
  User get _user {
    _$_userAtom.context.enforceReadPolicy(_$_userAtom);
    _$_userAtom.reportObserved();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.context.conditionallyRunInAction(() {
      super._user = value;
      _$_userAtom.reportChanged();
    }, _$_userAtom, name: '${_$_userAtom.name}_set');
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setUser(User user) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setUser(user);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isAuthenticated: ${isAuthenticated.toString()},user: ${user.toString()}';
    return '{$string}';
  }
}
