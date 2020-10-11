import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/datasources/cart_data_source.dart';

part 'remove_all_cart.g.dart';

abstract class RemoveAllCart {
  void call();
}

@Injectable()
class RemoveAllCartImpl implements RemoveAllCart {
  CartDataSource _cartDataSource;
  RemoveAllCartImpl(this._cartDataSource);

  @override
  void call() {
    _cartDataSource.removeAll();
  }
}
