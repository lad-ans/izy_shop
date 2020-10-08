import 'package:flutter/widgets.dart';

import '../../../customer/data/models/customer_model.dart';

abstract class AuthRepository {
  Future<void> signIn(CustomerModel customerModel);
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signUp(CustomerModel customerModel);
  Future<void> signOut();
}
