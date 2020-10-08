import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../presentation/stores/get_logged_customer_store.dart';

class LoggedUser {
  final getCustomer = Modular.get<GetLoggedCustomerStore>();
  static final LoggedUser instance = LoggedUser._internal();

  LoggedUser._internal();
  factory LoggedUser() => instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get loggedUserUid => _auth?.currentUser?.uid;
  String get loggedUsername => _auth?.currentUser?.displayName;
}
