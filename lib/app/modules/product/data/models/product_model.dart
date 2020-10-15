
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String img;
  String category;
  String description;
  num price;
  int qty;
  num deliveryPrice;
  bool hasWeight;
  bool hasVol;
  bool hasSize;
  Map<String, dynamic> customPrice;
  Map<String, dynamic> selectedItem;
  DocumentReference reference;
  String storeCategory;
  String storeName;
  ProductModel({
    this.id,
    this.name,
    this.img,
    this.category,
    this.description,
    this.price,
    this.qty,
    this.deliveryPrice,
    this.hasWeight,
    this.hasVol,
    this.hasSize,
    this.customPrice,
    this.selectedItem,
    this.reference,
    this.storeCategory,
    this.storeName,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      name: doc.data()['name'],
      img: doc.data()['logo'],
      description: doc.data()['description'],
      price: doc.data()['price'],
      category: doc.data()['category'],
      qty: doc.data()['qty'],
      id: doc.data()['id'],
      hasVol: doc.data()['hasVol'],
      hasWeight: doc.data()['hasWeight'],
      hasSize: doc.data()['hasSize'],
      deliveryPrice: doc.data()['deliveryPrice'],
      reference: doc.reference,
      storeCategory: doc.data()['storeCategory'],
      storeName: doc.data()['storeName'],
      customPrice: doc.data()['customPrice'],
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        name: map['name'],
        img: map['logo'],
        description: map['description'],
        price: map['price'],
        category: map['category'],
        qty: map['qty'],
        id: map['id'],
        hasVol: map['hasVol'],
        hasWeight: map['hasWeight'],
        hasSize: map['hasSize'],
        deliveryPrice: map['deliveryPrice'],
        storeCategory: map['storeCategory'],
        storeName: map['storeName'],
        selectedItem: map['selectedItem']);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "category": this.category,
      "description": this.description,
      "logo": this.img,
      "price": this.price,
      'qty': this.qty,
      'id': this.id,
      'hasVol': this.hasVol,
      'hasWeight': this.hasWeight,
      'hasSize': this.hasSize,
      'storeCategory': this.storeCategory,
      'storeName': this.storeName,
      'selectedItem': this.selectedItem,
    };
  }

  @override
  String toString() {
    return '${this.name}, ${this.name}, ${this.description}, ${this.img}, ${this.price}, ${this.category}, has size: ${this.hasSize}, has volume: ${this.hasVol}, has size: ${this.hasSize}, Store cat $storeCategory, Store name $storeName, selected item $selectedItem';
  }
}
