// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<dynamic> _$isAuthenticatedComputed;

  @override
  dynamic get isAuthenticated => (_$isAuthenticatedComputed ??=
          Computed<dynamic>(() => super.isAuthenticated,
              name: '_UserStore.isAuthenticated'))
      .value;
  Computed<dynamic> _$userComputed;

  @override
  dynamic get user => (_$userComputed ??=
          Computed<dynamic>(() => super.user, name: '_UserStore.user'))
      .value;

  final _$_userAtom = Atom(name: '_UserStore._user');

  @override
  User get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setUser(User user) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAuthenticated: ${isAuthenticated},
user: ${user}
    ''';
  }
}
