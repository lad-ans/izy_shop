import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../product/data/models/product_model.dart';
import '../../data/datasources/cart_data_source.dart';

part 'add_to_cart.g.dart';

abstract class AddToCart {
  void call(ProductModel productModel);
}

@Injectable()
class AddToCartImpl implements AddToCart {
  CartDataSource _cartDataSource;
  AddToCartImpl(this._cartDataSource);

  @override
  void call(ProductModel productModel) {
    _cartDataSource.addToCart(productModel);
  }
}
