import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../modules/checkout/data/models/order_model.dart';
import '../../../modules/product/data/models/product_model.dart';

class RouteEntity {
  final num totalAmount;
  final String storeCategory;
  final List productCategories;
  final String storeImg;
  final String storeName;
  final DocumentReference storeRef;
  final ProductModel productModel;
  final List<ProductModel> cartList;
  final TextEditingController addressController;
  final OrderModel orderModel;

  RouteEntity({
    this.totalAmount,
    this.storeCategory,
    this.productCategories,
    this.storeImg,
    this.storeName,
    this.storeRef,
    this.productModel,
    this.cartList,
    this.addressController,
    this.orderModel,
  });
}
