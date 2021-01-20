// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SignInStore = BindInject(
  (i) => SignInStore(i<SignIn>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInStore on _SignInStoreBase, Store {
  final _$executeSignInAsyncAction =
      AsyncAction('_SignInStoreBase.executeSignIn');

  @override
  Future<void> executeSignIn(CustomerModel customerModel, dynamic context) {
    return _$executeSignInAsyncAction
        .run(() => super.executeSignIn(customerModel, context));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
