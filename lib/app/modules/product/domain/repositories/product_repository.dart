import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Stream<List<ProductModel>> getProduct(DocumentReference reference);

  Future<void> addToCart(ProductModel productModel);
}
