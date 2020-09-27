// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AddToCartStore = BindInject(
  (i) => AddToCartStore(i<AddToCart>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddToCartStore on _AddToCartStoreBase, Store {
  final _$dragFeedbackColorAtom =
      Atom(name: '_AddToCartStoreBase.dragFeedbackColor');

  @override
  Color get dragFeedbackColor {
    _$dragFeedbackColorAtom.reportRead();
    return super.dragFeedbackColor;
  }

  @override
  set dragFeedbackColor(Color value) {
    _$dragFeedbackColorAtom.reportWrite(value, super.dragFeedbackColor, () {
      super.dragFeedbackColor = value;
    });
  }

  final _$_AddToCartStoreBaseActionController =
      ActionController(name: '_AddToCartStoreBase');

  @override
  dynamic setDragFeedbackColor(Color color) {
    final _$actionInfo = _$_AddToCartStoreBaseActionController.startAction(
        name: '_AddToCartStoreBase.setDragFeedbackColor');
    try {
      return super.setDragFeedbackColor(color);
    } finally {
      _$_AddToCartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dragFeedbackColor: ${dragFeedbackColor}
    ''';
  }
}
