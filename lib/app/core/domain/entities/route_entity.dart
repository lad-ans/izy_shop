import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:izy_shop/app/modules/product/data/models/product_model.dart';

class RouteEntity {
  final num totalAmount;
  final String storeName;
  final List productCategories;
  final String storeImg;
  final DocumentReference storeRef;
  final ProductModel productModel;
  final List<ProductModel> cartList;

  RouteEntity({
    this.totalAmount,
    this.storeName,
    this.productCategories,
    this.storeImg,
    this.storeRef,
    this.productModel,
    this.cartList,
  });
}
