import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/domain/utils/global_scaffold.dart';
import '../../../customer/data/models/customer_model.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@Injectable()
class AuthRepositoryImpl implements AuthRepository {
  FirebaseFirestore _firestore;

  AuthRepositoryImpl(
    this._firestore,
  );

  /// email pssword signin
  @override
  Future<void> signIn(CustomerModel customerModel) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: customerModel.email.trim(),
        password: customerModel.password,
      );
    } on FirebaseAuthException catch (e) {
      Modular.to.pop();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return GlobalScaffold.instance.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 30.0),
                Text(
                  'User not found',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return GlobalScaffold.instance.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 30.0),
                Text(
                  'Wrong password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      Modular.to.pop();
    }
  }

  /// email pssword signup
  @override
  Future<void> signUp(CustomerModel customerModel) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: customerModel.email.trim(),
        password: customerModel.password,
      );

      /// saving customer data on firestore
      await _firestore.collection('customers').doc(userCredential.user.uid).set(
            customerModel.toMap(userCredential.user),
          );
    } on FirebaseAuthException catch (e) {
      Modular.to.pop();
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return GlobalScaffold.instance.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 30.0),
                Text(
                  'Weak password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return GlobalScaffold.instance.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 30.0),
                Text(
                  'Email already in use',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      Modular.to.pop();
      print(e.toString());
    }
  }

  /// google sign in
  @override
  Future<void> signInWithGoogle() async {
    CustomerModel customerModel = CustomerModel();
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      /// saving customer data on firestore
      await _firestore
          .collection('customers')
          .doc(userCredential.user.uid)
          .set(customerModel.socialToMap(userCredential.user));
    } catch (e) {
      Modular.to.pop();
      print(e.toString());
      return e;
    }
  }

  /// facebook sign in
  @override
  Future<void> signInWithFacebook() async {
    CustomerModel customerModel = CustomerModel();
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      /// saving customer data on firestore
      await _firestore
          .collection('customers')
          .doc(userCredential.user.uid)
          .set(customerModel.socialToMap(userCredential.user));
    } catch (e) {
      Modular.to.pop();
      print(e.toString());
      return e;
    }
  }

  /// sign out
  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
