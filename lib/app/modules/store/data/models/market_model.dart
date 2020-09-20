import 'package:cloud_firestore/cloud_firestore.dart';

class MarketModel {
  String name;
  String logo;
  String docId;
  String collection;
  MarketModel({
    this.name,
    this.logo,
    this.docId,
    this.collection,
  });

  factory MarketModel.fromDocument(DocumentSnapshot doc) {
    return MarketModel(
      name: doc['name'],
      logo: doc['logo'],
    );
  }

  Future save() async {
    Firestore.instance
        .collection('list')
        .document(docId)
        .collection(collection);
  }
}
