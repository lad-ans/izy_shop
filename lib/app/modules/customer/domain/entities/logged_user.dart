import 'package:firebase_auth/firebase_auth.dart';

class LoggedUser {
  static final LoggedUser instance = LoggedUser._internal();

  LoggedUser._internal();
  factory LoggedUser() => instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get loggedUserUid => _auth?.currentUser?.uid;
}
