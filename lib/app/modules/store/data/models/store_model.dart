import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String name;
  String logo;
  List category;
  DocumentReference reference;
  StoreModel({
    this.name,
    this.logo,
    this.category,
    this.reference,
  });

  factory StoreModel.fromDocument(DocumentSnapshot doc) {
    return StoreModel(
      name: doc['name'],
      logo: doc['logo'],
      category: doc['category'],
      reference: doc.reference,
    );
  }
  Future save(String collPath) async {
    Firestore.instance
        .collection('market')
        .document('5OX5YOeZJAnflZlewMzA')
        .collection(collPath);
  }
}
