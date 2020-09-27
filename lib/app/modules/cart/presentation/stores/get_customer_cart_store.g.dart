// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_cart_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetCustomerCartStore = BindInject(
  (i) => GetCustomerCartStore(i<GetCustomerCart>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetCustomerCartStore on _GetCustomerCartStoreBase, Store {
  final _$cartListAtom = Atom(name: '_GetCustomerCartStoreBase.cartList');

  @override
  ObservableStream<List<ProductModel>> get cartList {
    _$cartListAtom.reportRead();
    return super.cartList;
  }

  @override
  set cartList(ObservableStream<List<ProductModel>> value) {
    _$cartListAtom.reportWrite(value, super.cartList, () {
      super.cartList = value;
    });
  }

  final _$_GetCustomerCartStoreBaseActionController =
      ActionController(name: '_GetCustomerCartStoreBase');

  @override
  dynamic execute(String uuid) {
    final _$actionInfo = _$_GetCustomerCartStoreBaseActionController
        .startAction(name: '_GetCustomerCartStoreBase.execute');
    try {
      return super.execute(uuid);
    } finally {
      _$_GetCustomerCartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartList: ${cartList}
    ''';
  }
}
