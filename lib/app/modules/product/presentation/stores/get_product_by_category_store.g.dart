// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_by_category_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetProductByCategoryStore = BindInject(
  (i) => GetProductByCategoryStore(
      getProductByCategory: i<GetProductByCategory>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetProductByCategoryStore on _GetProductByCategoryStoreBase, Store {
  final _$productsAtom = Atom(name: '_GetProductByCategoryStoreBase.products');

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

  final _$_GetProductByCategoryStoreBaseActionController =
      ActionController(name: '_GetProductByCategoryStoreBase');

  @override
  dynamic execute(DocumentReference reference, List<dynamic> prodCategories) {
    final _$actionInfo = _$_GetProductByCategoryStoreBaseActionController
        .startAction(name: '_GetProductByCategoryStoreBase.execute');
    try {
      return super.execute(reference, prodCategories);
    } finally {
      _$_GetProductByCategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
