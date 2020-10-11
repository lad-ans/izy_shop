import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:izy_shop/app/modules/cart/domain/usecases/remove_from_cart.dart';
import 'package:izy_shop/app/modules/product/data/models/product_model.dart';
import 'package:mobx/mobx.dart';
part 'remove_from_cart_store.g.dart';

@Injectable()
class RemoveFromCartStore = _RemoveFromCartStoreBase with _$RemoveFromCartStore;

abstract class _RemoveFromCartStoreBase with Store {
  final RemoveFromCart _removeFromCart;

  _RemoveFromCartStoreBase(this._removeFromCart);

  @action
  void execute(ProductModel productModel) {
    _removeFromCart(productModel);
  }
}
