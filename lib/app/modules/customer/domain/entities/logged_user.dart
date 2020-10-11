import 'package:firebase_auth/firebase_auth.dart';
import 'package:izy_shop/app/core/domain/consts/img.dart';
import 'package:izy_shop/app/modules/customer/data/datasources/local_storage.dart';

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
