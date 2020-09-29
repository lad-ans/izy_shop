import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String name;
  String img;
  String category;
  String description;
  num price;
  String size;
  int qty;
  DocumentReference reference;
  ProductModel({
    this.name,
    this.img,
    this.category,
    this.description,
    this.price,
    this.size,
    this.qty,
    this.reference,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      name: doc['name'],
      img: doc['logo'],
      description: doc['description'],
      price: doc['price'],
      size: doc['size'],
      category: doc['category'],
      qty: doc['qty'],
      reference: doc.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "category": this.category,
      "description": this.description,
      "logo": this.img,
      "price": this.price,
      "size": this.size,
      'qty': this.qty
    };
  }

  @override
  String toString() {
    return '${this.name}, ${this.description}, ${this.img}, ${this.price}, ${this.category}, ${this.size}';
  }
}
