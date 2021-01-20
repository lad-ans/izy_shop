import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/data/datasources/local_storage.dart';
import '../../../../core/domain/consts/img.dart';

class LoggedUser {
  static final LoggedUser instance = LoggedUser._internal();

  LoggedUser._internal();
  factory LoggedUser() => instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get loggedUserUid => _auth?.currentUser?.uid;
  String get loggedUsername {
    String customerName;
    if (_auth?.currentUser?.displayName != null) {
      customerName = _auth?.currentUser?.displayName;
    } else {
      LocalStorage.instance.getString(CUSTOMER).then((value) {
        customerName = value;
      });
    }
    return customerName;
  }
}
