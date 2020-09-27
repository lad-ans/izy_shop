import '../../../product/data/models/product_model.dart';

abstract class CartRepository {
  Stream<List<ProductModel>> getCustomerCart(String uuid);
}
