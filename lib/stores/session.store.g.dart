// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SessionStore on _SessionStore, Store {
  Computed<dynamic> _$tokenComputed;

  @override
  dynamic get token =>
      (_$tokenComputed ??= Computed<dynamic>(() => super.token)).value;
  Computed<dynamic> _$expiryDateComputed;

  @override
  dynamic get expiryDate =>
      (_$expiryDateComputed ??= Computed<dynamic>(() => super.expiryDate))
          .value;
  Computed<dynamic> _$authTimerComputed;

  @override
  dynamic get authTimer =>
      (_$authTimerComputed ??= Computed<dynamic>(() => super.authTimer)).value;

  final _$_tokenAtom = Atom(name: '_SessionStore._token');

  @override
  String get _token {
    _$_tokenAtom.context.enforceReadPolicy(_$_tokenAtom);
    _$_tokenAtom.reportObserved();
    return super._token;
  }

  @override
  set _token(String value) {
    _$_tokenAtom.context.conditionallyRunInAction(() {
      super._token = value;
      _$_tokenAtom.reportChanged();
    }, _$_tokenAtom, name: '${_$_tokenAtom.name}_set');
  }

  final _$_expiryDateAtom = Atom(name: '_SessionStore._expiryDate');

  @override
  DateTime get _expiryDate {
    _$_expiryDateAtom.context.enforceReadPolicy(_$_expiryDateAtom);
    _$_expiryDateAtom.reportObserved();
    return super._expiryDate;
  }

  @override
  set _expiryDate(DateTime value) {
    _$_expiryDateAtom.context.conditionallyRunInAction(() {
      super._expiryDate = value;
      _$_expiryDateAtom.reportChanged();
    }, _$_expiryDateAtom, name: '${_$_expiryDateAtom.name}_set');
  }

  final _$_authTimerAtom = Atom(name: '_SessionStore._authTimer');

  @override
  Timer get _authTimer {
    _$_authTimerAtom.context.enforceReadPolicy(_$_authTimerAtom);
    _$_authTimerAtom.reportObserved();
    return super._authTimer;
  }

  @override
  set _authTimer(Timer value) {
    _$_authTimerAtom.context.conditionallyRunInAction(() {
      super._authTimer = value;
      _$_authTimerAtom.reportChanged();
    }, _$_authTimerAtom, name: '${_$_authTimerAtom.name}_set');
  }

  final _$authenticateAsyncAction = AsyncAction('authenticate');

  @override
  Future<dynamic> authenticate(SignInViewModel signInViewModel) {
    return _$authenticateAsyncAction
        .run(() => super.authenticate(signInViewModel));
  }

  final _$signUpAsyncAction = AsyncAction('signUp');

  @override
  Future<bool> signUp(SignUpViewModel model) {
    return _$signUpAsyncAction.run(() => super.signUp(model));
  }

  final _$signOutAsyncAction = AsyncAction('signOut');

  @override
  Future<dynamic> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$setSessionAsyncAction = AsyncAction('setSession');

  @override
  Future<dynamic> setSession() {
    return _$setSessionAsyncAction.run(() => super.setSession());
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$tryAutoLoginAsyncAction = AsyncAction('tryAutoLogin');

  @override
  Future<User> tryAutoLogin() {
    return _$tryAutoLoginAsyncAction.run(() => super.tryAutoLogin());
  }

  final _$_SessionStoreActionController =
      ActionController(name: '_SessionStore');

  @override
  void _autoLogout() {
    final _$actionInfo = _$_SessionStoreActionController.startAction();
    try {
      return super._autoLogout();
    } finally {
      _$_SessionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'token: ${token.toString()},expiryDate: ${expiryDate.toString()},authTimer: ${authTimer.toString()}';
    return '{$string}';
  }
}
