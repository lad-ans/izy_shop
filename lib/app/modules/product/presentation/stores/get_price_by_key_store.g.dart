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

  final _$keyReceiverAtom = Atom(name: '_GetPriceByKeyStoreBase.keyReceiver');

  @override
  String get keyReceiver {
    _$keyReceiverAtom.reportRead();
    return super.keyReceiver;
  }

  @override
  set keyReceiver(String value) {
    _$keyReceiverAtom.reportWrite(value, super.keyReceiver, () {
      super.keyReceiver = value;
    });
  }

  final _$selectedCustomPriceKeyAtom =
      Atom(name: '_GetPriceByKeyStoreBase.selectedCustomPriceKey');

  @override
  String get selectedCustomPriceKey {
    _$selectedCustomPriceKeyAtom.reportRead();
    return super.selectedCustomPriceKey;
  }

  @override
  set selectedCustomPriceKey(String value) {
    _$selectedCustomPriceKeyAtom
        .reportWrite(value, super.selectedCustomPriceKey, () {
      super.selectedCustomPriceKey = value;
    });
  }

  final _$selectedCustomPriceValueAtom =
      Atom(name: '_GetPriceByKeyStoreBase.selectedCustomPriceValue');

  @override
  num get selectedCustomPriceValue {
    _$selectedCustomPriceValueAtom.reportRead();
    return super.selectedCustomPriceValue;
  }

  @override
  set selectedCustomPriceValue(num value) {
    _$selectedCustomPriceValueAtom
        .reportWrite(value, super.selectedCustomPriceValue, () {
      super.selectedCustomPriceValue = value;
    });
  }

  final _$selectedItemAtom = Atom(name: '_GetPriceByKeyStoreBase.selectedItem');

  @override
  Map<String, dynamic> get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(Map<String, dynamic> value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
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
  void resetSelectedItem() {
    final _$actionInfo = _$_GetPriceByKeyStoreBaseActionController.startAction(
        name: '_GetPriceByKeyStoreBase.resetSelectedItem');
    try {
      return super.resetSelectedItem();
    } finally {
      _$_GetPriceByKeyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customPrice: ${customPrice},
keyReceiver: ${keyReceiver},
selectedCustomPriceKey: ${selectedCustomPriceKey},
selectedCustomPriceValue: ${selectedCustomPriceValue},
selectedItem: ${selectedItem}
    ''';
  }
}
