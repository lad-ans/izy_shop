import 'package:cloud_firestore/cloud_firestore.dart';

class RouteEntity {
  final String marketName;
  final List productCategories;
  final String storeImg;
  final DocumentReference storeRef;
  RouteEntity({
    this.marketName,
    this.productCategories,
    this.storeImg,
    this.storeRef,
  });
}
