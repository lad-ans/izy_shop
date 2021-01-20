// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data_source.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $CartDataSource = BindInject(
  (i) => CartDataSource(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartDataSource on _CartDataSourceBase, Store {
  final _$customerCartAtom = Atom(name: '_CartDataSourceBase.customerCart');

  @override
  ObservableList<ProductModel> get customerCart {
    _$customerCartAtom.reportRead();
    return super.customerCart;
  }

  @override
  set customerCart(ObservableList<ProductModel> value) {
    _$customerCartAtom.reportWrite(value, super.customerCart, () {
      super.customerCart = value;
    });
  }

  final _$_CartDataSourceBaseActionController =
      ActionController(name: '_CartDataSourceBase');

  @override
  void addToCart(ProductModel productModel) {
    final _$actionInfo = _$_CartDataSourceBaseActionController.startAction(
        name: '_CartDataSourceBase.addToCart');
    try {
      return super.addToCart(productModel);
    } finally {
      _$_CartDataSourceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(ProductModel productModel) {
    final _$actionInfo = _$_CartDataSourceBaseActionController.startAction(
        name: '_CartDataSourceBase.removeFromCart');
    try {
      return super.removeFromCart(productModel);
    } finally {
      _$_CartDataSourceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAll() {
    final _$actionInfo = _$_CartDataSourceBaseActionController.startAction(
        name: '_CartDataSourceBase.removeAll');
    try {
      return super.removeAll();
    } finally {
      _$_CartDataSourceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customerCart: ${customerCart}
    ''';
  }
}
