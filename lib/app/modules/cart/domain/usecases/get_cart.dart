import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../product/data/models/product_model.dart';
import '../../data/datasources/cart_data_source.dart';

part 'get_cart.g.dart';

abstract class GetCart {
  List<ProductModel> call();
}

@Injectable()
class GetCartImpl implements GetCart {
  CartDataSource _cartDataSource;
  GetCartImpl(this._cartDataSource);

  @override
  List<ProductModel> call() {
    return _cartDataSource.getCart();
  }
}
