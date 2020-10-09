// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_delivery_time_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SetDeliveryTimeStore = BindInject(
  (i) => SetDeliveryTimeStore(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SetDeliveryTimeStore on _SetDeliveryTimeStoreBase, Store {
  final _$deliveryTimeAtom =
      Atom(name: '_SetDeliveryTimeStoreBase.deliveryTime');

  @override
  String get deliveryTime {
    _$deliveryTimeAtom.reportRead();
    return super.deliveryTime;
  }

  @override
  set deliveryTime(String value) {
    _$deliveryTimeAtom.reportWrite(value, super.deliveryTime, () {
      super.deliveryTime = value;
    });
  }

  final _$_SetDeliveryTimeStoreBaseActionController =
      ActionController(name: '_SetDeliveryTimeStoreBase');

  @override
  dynamic setDeliveryTime(String time) {
    final _$actionInfo = _$_SetDeliveryTimeStoreBaseActionController
        .startAction(name: '_SetDeliveryTimeStoreBase.setDeliveryTime');
    try {
      return super.setDeliveryTime(time);
    } finally {
      _$_SetDeliveryTimeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
deliveryTime: ${deliveryTime}
    ''';
  }
}
