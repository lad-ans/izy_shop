import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../product/data/models/product_model.dart';
import '../../data/datasources/cart_data_source.dart';

part 'remove_from_cart.g.dart';

abstract class RemoveFromCart {
  void call(ProductModel productModel);
}

@Injectable()
class RemoveFromCartImpl implements RemoveFromCart {
  CartDataSource _cartDataSource;
  RemoveFromCartImpl(this._cartDataSource);

  @override
  void call(ProductModel productModel) {
    _cartDataSource.removeFromCart(productModel);
  }
}
