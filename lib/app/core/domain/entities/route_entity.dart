import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:izy_shop/app/modules/product/data/models/product_model.dart';

class RouteEntity {
  final String marketName;
  final List productCategories;
  final String storeImg;
  final DocumentReference storeRef;
  final ProductModel productModel;
  RouteEntity({
    this.marketName,
    this.productCategories,
    this.storeImg,
    this.storeRef,
    this.productModel,
  });
}
