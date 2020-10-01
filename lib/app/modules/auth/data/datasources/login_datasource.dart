import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../customer/data/models/customer_model.dart';

abstract class LoginDataSource {
  Future<CustomerModel> loginEmail({String email, String password});
  Future<CustomerModel> currentUser();
  Future<void> logout();
}

class LogginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth auth;

  LogginDataSourceImpl(this.auth);

  @override
  Future<CustomerModel> loginEmail({String email, String password}) async {
    var result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = result.user;
    return CustomerModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<CustomerModel> currentUser() async {
    var user = auth.currentUser;
    assert(user != null);
    return CustomerModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<void> logout() async {
    return await auth.signOut();
  }
}
