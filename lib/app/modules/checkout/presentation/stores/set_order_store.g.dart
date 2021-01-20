// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_order_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SetOrderStore = BindInject(
  (i) => SetOrderStore(i<SetOrder>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SetOrderStore on _SetOrderStoreBase, Store {
  final _$executeAsyncAction = AsyncAction('_SetOrderStoreBase.execute');

  @override
  Future execute(OrderModel orderModel) {
    return _$executeAsyncAction.run(() => super.execute(orderModel));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
