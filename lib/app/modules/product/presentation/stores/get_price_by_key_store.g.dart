// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_price_by_key_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetPriceByKeyStore = BindInject(
  (i) => GetPriceByKeyStore(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetPriceByKeyStore on _GetPriceByKeyStoreBase, Store {
  final _$customPriceAtom = Atom(name: '_GetPriceByKeyStoreBase.customPrice');

  @override
  num get customPrice {
    _$customPriceAtom.reportRead();
    return super.customPrice;
  }

  @override
  set customPrice(num value) {
    _$customPriceAtom.reportWrite(value, super.customPrice, () {
      super.customPrice = value;
    });
  }

  final _$isSelectedAtom = Atom(name: '_GetPriceByKeyStoreBase.isSelected');

  @override
  String get isSelected {
    _$isSelectedAtom.reportRead();
    return super.isSelected;
  }

  @override
  set isSelected(String value) {
    _$isSelectedAtom.reportWrite(value, super.isSelected, () {
      super.isSelected = value;
    });
  }

  final _$_GetPriceByKeyStoreBaseActionController =
      ActionController(name: '_GetPriceByKeyStoreBase');

  @override
  dynamic selectKey(String key, Map<String, dynamic> map) {
    final _$actionInfo = _$_GetPriceByKeyStoreBaseActionController.startAction(
        name: '_GetPriceByKeyStoreBase.selectKey');
    try {
      return super.selectKey(key, map);
    } finally {
      _$_GetPriceByKeyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customPrice: ${customPrice},
isSelected: ${isSelected}
    ''';
  }
}
