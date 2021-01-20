// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetProductStore = BindInject(
  (i) => GetProductStore(getProduct: i<GetProduct>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetProductStore on _GetProductStoreBase, Store {
  final _$productsAtom = Atom(name: '_GetProductStoreBase.products');

  @override
  ObservableStream<List<ProductModel>> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableStream<List<ProductModel>> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  final _$_GetProductStoreBaseActionController =
      ActionController(name: '_GetProductStoreBase');

  @override
  dynamic execute(DocumentReference reference) {
    final _$actionInfo = _$_GetProductStoreBaseActionController.startAction(
        name: '_GetProductStoreBase.execute');
    try {
      return super.execute(reference);
    } finally {
      _$_GetProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
