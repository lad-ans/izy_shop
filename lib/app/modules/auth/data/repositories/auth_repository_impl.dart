import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../customer/data/models/customer_model.dart';
import '../../domain/repositories/auth_repository.dart';
part 'auth_repository_impl.g.dart';

@Injectable()
class AuthRepositoryImpl implements AuthRepository {
  FirebaseFirestore _flutterFire;

  AuthRepositoryImpl(
    this._flutterFire,
  );

  @override
  Future<void> signIn(CustomerModel customerModel) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: customerModel.email,
        password: customerModel.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {}
  }

  @override
  Future<void> signUp(CustomerModel customerModel) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: customerModel.email,
        password: customerModel.password,
      );
      /// saving customer data on firestore
      await _flutterFire
          .collection('customers')
          .doc(userCredential.user.uid)
          .set(
            customerModel.toMap(userCredential.user),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    CustomerModel.fromDocument(null);
  }
}
