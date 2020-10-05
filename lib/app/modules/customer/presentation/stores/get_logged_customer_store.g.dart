// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_logged_customer_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GetLoggedCustomerStore = BindInject(
  (i) => GetLoggedCustomerStore(i<GetLoggedCustomer>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetLoggedCustomerStore on _GetLoggedCustomerStoreBase, Store {
  final _$currentCustomerAtom =
      Atom(name: '_GetLoggedCustomerStoreBase.currentCustomer');

  @override
  ObservableStream<CustomerModel> get currentCustomer {
    _$currentCustomerAtom.reportRead();
    return super.currentCustomer;
  }

  @override
  set currentCustomer(ObservableStream<CustomerModel> value) {
    _$currentCustomerAtom.reportWrite(value, super.currentCustomer, () {
      super.currentCustomer = value;
    });
  }

  final _$_GetLoggedCustomerStoreBaseActionController =
      ActionController(name: '_GetLoggedCustomerStoreBase');

  @override
  dynamic execute(String uid) {
    final _$actionInfo = _$_GetLoggedCustomerStoreBaseActionController
        .startAction(name: '_GetLoggedCustomerStoreBase.execute');
    try {
      return super.execute(uid);
    } finally {
      _$_GetLoggedCustomerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentCustomer: ${currentCustomer}
    ''';
  }
}
