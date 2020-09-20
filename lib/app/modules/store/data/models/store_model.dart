import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String name;
  String logo;
  StoreModel({
    this.name,
    this.logo,
  });

  factory StoreModel.fromDocument(DocumentSnapshot doc) {
    return StoreModel(
      name: doc['name'],
      logo: doc['logo'],
    );
  }
  Future save(String collPath) async {
    Firestore.instance
        .collection('market')
        .document('5OX5YOeZJAnflZlewMzA')
        .collection(collPath);
  }
}
