import 'package:cloud_firestore/cloud_firestore.dart';

class StoreCategoryModel {
  String name;
  String logo;
  String docId;
  String collection;
  StoreCategoryModel({
    this.name,
    this.logo,
    this.docId,
    this.collection,
  });

  factory StoreCategoryModel.fromDocument(DocumentSnapshot doc) {
    return StoreCategoryModel(
      name: doc.data()['name'],
      logo: doc.data()['logo'],
    );
  }
}
