// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_market_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetStoreStore = BindInject(
  (i) => GetStoreStore(getStore: i<GetStore>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetStoreStore on _GetStoreStoreBase, Store {
  final _$marketListAtom = Atom(name: '_GetStoreStoreBase.marketList');

  @override
  ObservableStream<List<MarketModel>> get marketList {
    _$marketListAtom.reportRead();
    return super.marketList;
  }

  @override
  set marketList(ObservableStream<List<MarketModel>> value) {
    _$marketListAtom.reportWrite(value, super.marketList, () {
      super.marketList = value;
    });
  }

  final _$_GetStoreStoreBaseActionController =
      ActionController(name: '_GetStoreStoreBase');

  @override
  dynamic execute() {
    final _$actionInfo = _$_GetStoreStoreBaseActionController.startAction(
        name: '_GetStoreStoreBase.execute');
    try {
      return super.execute();
    } finally {
      _$_GetStoreStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
marketList: ${marketList}
    ''';
  }
}
