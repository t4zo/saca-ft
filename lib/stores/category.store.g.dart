// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryStore on _CategoryStore, Store {
  Computed<List<CategoryViewModel>> _$categoriesComputed;

  @override
  List<CategoryViewModel> get categories => (_$categoriesComputed ??=
          Computed<List<CategoryViewModel>>(() => super.categories,
              name: '_CategoryStore.categories'))
      .value;
  Computed<List<Image>> _$imagesComputed;

  @override
  List<Image> get images =>
      (_$imagesComputed ??= Computed<List<Image>>(() => super.images,
              name: '_CategoryStore.images'))
          .value;

  final _$_categoriesAtom = Atom(name: '_CategoryStore._categories');

  @override
  Iterable<CategoryViewModel> get _categories {
    _$_categoriesAtom.reportRead();
    return super._categories;
  }

  @override
  set _categories(Iterable<CategoryViewModel> value) {
    _$_categoriesAtom.reportWrite(value, super._categories, () {
      super._categories = value;
    });
  }

  final _$getAllAsyncAsyncAction = AsyncAction('_CategoryStore.getAllAsync');

  @override
  Future<String> getAllAsync() {
    return _$getAllAsyncAsyncAction.run(() => super.getAllAsync());
  }

  final _$addImageAsyncAsyncAction =
      AsyncAction('_CategoryStore.addImageAsync');

  @override
  Future<String> addImageAsync(ImageViewModel imageViewModel) {
    return _$addImageAsyncAsyncAction
        .run(() => super.addImageAsync(imageViewModel));
  }

  final _$updateImageAsyncAsyncAction =
      AsyncAction('_CategoryStore.updateImageAsync');

  @override
  Future<String> updateImageAsync(ImageViewModel image) {
    return _$updateImageAsyncAsyncAction
        .run(() => super.updateImageAsync(image));
  }

  final _$removeImageAsyncAsyncAction =
      AsyncAction('_CategoryStore.removeImageAsync');

  @override
  Future<String> removeImageAsync(Image image) {
    return _$removeImageAsyncAsyncAction
        .run(() => super.removeImageAsync(image));
  }

  final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore');

  @override
  void toggleExpanded(int index, bool isExpanded) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction(
        name: '_CategoryStore.toggleExpanded');
    try {
      return super.toggleExpanded(index, isExpanded);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categories: ${categories},
images: ${images}
    ''';
  }
}
