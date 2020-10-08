import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        // EdgeAlert.show(
        //   context,
        //   title: 'User notfound',
        //   description: 'No user found for that email.',
        //   gravity: EdgeAlert.BOTTOM,
        //   icon: Icons.info,
        //   backgroundColor: Colors.redAccent,
        //   duration: EdgeAlert.LENGTH_SHORT,
        // );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // EdgeAlert.show(
        //   context,
        //   title: 'Wrong password',
        //   description: 'Wrong password provided for that user.',
        //   gravity: EdgeAlert.BOTTOM,
        //   icon: Icons.info,
        //   backgroundColor: Colors.redAccent,
        //   duration: EdgeAlert.LENGTH_VERY_LONG,
        // );
      }
    } catch (e) {}
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
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        // EdgeAlert.show(
        //   context,
        //   title: 'Weak password',
        //   description: 'The password provided is too weak.',
        //   gravity: EdgeAlert.BOTTOM,
        //   icon: Icons.info,
        //   backgroundColor: Colors.redAccent,
        //   duration: EdgeAlert.LENGTH_VERY_LONG,
        // );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // EdgeAlert.show(
        //   context,
        //   title: 'Email already in use',
        //   description: 'The account already exists for that email.',
        //   gravity: EdgeAlert.BOTTOM,
        //   icon: Icons.info,
        //   backgroundColor: Colors.redAccent,
        //   duration: EdgeAlert.LENGTH_VERY_LONG,
        // );
      }
    } catch (e) {
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
