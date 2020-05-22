// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SessionStore on _SessionStore, Store {
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

  @override
  String toString() {
    final string = '';
    return '{$string}';
  }
}
