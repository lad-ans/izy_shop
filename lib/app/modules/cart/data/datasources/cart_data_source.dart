import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../product/data/models/product_model.dart';
part 'cart_data_source.g.dart';

abstract class CartDataSource {
  void addToCart(ProductModel productModel);
  void removeFromCart(ProductModel productModel);
  List<ProductModel> getCart();
  void removeAll();
}

@Injectable()
class CartDataSourceImpl implements CartDataSource {
  List<ProductModel> customerCart = [];
  @override
  void addToCart(ProductModel productModel) {
    customerCart.add(productModel);
  }

  @override
  void removeFromCart(ProductModel productModel) {
    customerCart.remove(productModel);
  }

  @override
  void removeAll() {
    customerCart.clear();
  }

  @override
  List<ProductModel> getCart() {
    return customerCart;
  }
}
