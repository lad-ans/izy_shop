// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_store_by_market_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetStoreByMarketStore = BindInject(
  (i) => GetStoreByMarketStore(getStoreByMarket: i<GetStoreByMarket>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetStoreByMarketStore on _GetStoreByMarketStoreBase, Store {
  final _$storeListAtom = Atom(name: '_GetStoreByMarketStoreBase.storeList');

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

  final _$_GetStoreByMarketStoreBaseActionController =
      ActionController(name: '_GetStoreByMarketStoreBase');

  @override
  dynamic execute(String market) {
    final _$actionInfo = _$_GetStoreByMarketStoreBaseActionController
        .startAction(name: '_GetStoreByMarketStoreBase.execute');
    try {
      return super.execute(market);
    } finally {
      _$_GetStoreByMarketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
storeList: ${storeList}
    ''';
  }
}
