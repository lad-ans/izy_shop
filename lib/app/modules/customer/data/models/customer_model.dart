import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomerModel {
  String name;
  String surname;
  String email;
  String avatar;
  String password;
  CustomerModel({
    this.name,
    this.surname,
    this.email,
    this.avatar,
    this.password,
  });

  factory CustomerModel.fromDocument(DocumentSnapshot snap) {
    return CustomerModel(
      name: snap.data()['name'],
      surname: snap.data()['surname'],
      email: snap.data()['email'],
      avatar: snap.data()['avatar'],
    );
  }

  Map<String, dynamic> toMap(User user) {
    return {
      'name': this.name,
      'surname': this.surname,
      'email': this.email,
      'avatar': this.avatar,
      'uid': user.uid
    };
  }

  Map<String, dynamic> googleUsetToMap(User user) {
    return {
      'name': user.displayName,
      'surname': '',
      'email': user.email,
      'avatar': user.photoURL,
      'uid': user.uid
    };
  }
}
