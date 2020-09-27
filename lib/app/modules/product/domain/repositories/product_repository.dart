import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Stream<List<ProductModel>> getProductByCategory(
      DocumentReference reference, String category);

  Future<void> addToCart(ProductModel productModel);
}
