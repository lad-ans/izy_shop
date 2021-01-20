import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String name;
  String logo;
  List categories;
  DocumentReference reference;
  StoreModel({
    this.name,
    this.logo,
    this.categories,
    this.reference,
  });

  factory StoreModel.fromDocument(DocumentSnapshot doc) {
    return StoreModel(
      name: doc.data()['name'],
      logo: doc.data()['logo'],
      categories: doc.data()['category'],
      reference: doc.reference,
    );
  }
}
