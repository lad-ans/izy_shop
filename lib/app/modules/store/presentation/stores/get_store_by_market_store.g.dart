// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_store_by_market_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetStoreByCategoryStore = BindInject(
  (i) => GetStoreByCategoryStore(getStoreByCategory: i<GetStoreByCategory>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetStoreByCategoryStore on _GetStoreByCategoryStoreBase, Store {
  final _$storeListAtom = Atom(name: '_GetStoreByCategoryStoreBase.storeList');

  @override
  ObservableStream<List<StoreModel>> get storeList {
    _$storeListAtom.reportRead();
    return super.storeList;
  }

  @override
  set storeList(ObservableStream<List<StoreModel>> value) {
    _$storeListAtom.reportWrite(value, super.storeList, () {
      super.storeList = value;
    });
  }

  final _$_GetStoreByCategoryStoreBaseActionController =
      ActionController(name: '_GetStoreByCategoryStoreBase');

  @override
  dynamic execute(String market) {
    final _$actionInfo = _$_GetStoreByCategoryStoreBaseActionController
        .startAction(name: '_GetStoreByCategoryStoreBase.execute');
    try {
      return super.execute(market);
    } finally {
      _$_GetStoreByCategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
storeList: ${storeList}
    ''';
  }
}
