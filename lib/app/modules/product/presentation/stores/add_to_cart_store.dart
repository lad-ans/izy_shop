import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/product_model.dart';
import '../../domain/usecases/add_to_cart.dart';

part 'add_to_cart_store.g.dart';

@Injectable()
class AddToCartStore = _AddToCartStoreBase with _$AddToCartStore;

abstract class _AddToCartStoreBase with Store {
  AddToCart _addToCart;
  _AddToCartStoreBase(
    this._addToCart,
  );

  Future<void> execute(ProductModel productModel) async {
    await _addToCart.call(productModel);
  }
}
