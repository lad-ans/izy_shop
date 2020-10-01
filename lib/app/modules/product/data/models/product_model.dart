import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String img;
  String category;
  String description;
  num price;
  String size;
  int qty;
  num deliveryPrice;
  DocumentReference reference;
  ProductModel({
    this.id,
    this.name,
    this.img,
    this.category,
    this.description,
    this.price,
    this.size,
    this.qty,
    this.deliveryPrice,
    this.reference,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      name: doc.data()['name'],
      img: doc.data()['logo'],
      description: doc.data()['description'],
      price: doc.data()['price'],
      size: doc.data()['size'],
      category: doc.data()['category'],
      qty: doc.data()['qty'],
      id: doc.data()['id'],
      deliveryPrice: doc.data()['deliveryPrice'],
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
      'qty': this.qty,
      'id': this.id
    };
  }

  @override
  String toString() {
    return '${this.name}, ${this.name}, ${this.description}, ${this.img}, ${this.price}, ${this.category}, ${this.size}';
  }
}
