// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryStore on _CategoryStore, Store {
  Computed<List<CategoryViewModel>> _$categoriesComputed;

  @override
  List<CategoryViewModel> get categories => (_$categoriesComputed ??=
          Computed<List<CategoryViewModel>>(() => super.categories))
      .value;

  final _$_categoriesAtom = Atom(name: '_CategoryStore._categories');

  @override
  List<CategoryViewModel> get _categories {
    _$_categoriesAtom.context.enforceReadPolicy(_$_categoriesAtom);
    _$_categoriesAtom.reportObserved();
    return super._categories;
  }

  @override
  set _categories(List<CategoryViewModel> value) {
    _$_categoriesAtom.context.conditionallyRunInAction(() {
      super._categories = value;
      _$_categoriesAtom.reportChanged();
    }, _$_categoriesAtom, name: '${_$_categoriesAtom.name}_set');
  }

  final _$addImageAsyncAction = AsyncAction('addImage');

  @override
  Future<bool> addImage(ImageViewModel imageViewModel) {
    return _$addImageAsyncAction.run(() => super.addImage(imageViewModel));
  }

  final _$updateImageAsyncAction = AsyncAction('updateImage');

  @override
  Future<bool> updateImage(ImageViewModel image) {
    return _$updateImageAsyncAction.run(() => super.updateImage(image));
  }

  final _$removeImageAsyncAction = AsyncAction('removeImage');

  @override
  Future<bool> removeImage(Image image) {
    return _$removeImageAsyncAction.run(() => super.removeImage(image));
  }

  final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore');

  @override
  void setCategories(List<CategoryViewModel> categories) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.setCategories(categories);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleExpanded(int index, bool isExpanded) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.toggleExpanded(index, isExpanded);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<Image> getAllImages() {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.getAllImages();
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'categories: ${categories.toString()}';
    return '{$string}';
  }
}
