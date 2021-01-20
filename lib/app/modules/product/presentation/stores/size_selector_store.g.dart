// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_selector_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SizeSelectorStore on _SizeSelectorStoreBase, Store {
  final _$indexAtom = Atom(name: '_SizeSelectorStoreBase.index');

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  final _$_SizeSelectorStoreBaseActionController =
      ActionController(name: '_SizeSelectorStoreBase');

  @override
  dynamic selector(int index) {
    final _$actionInfo = _$_SizeSelectorStoreBaseActionController.startAction(
        name: '_SizeSelectorStoreBase.selector');
    try {
      return super.selector(index);
    } finally {
      _$_SizeSelectorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
index: ${index}
    ''';
  }
}
