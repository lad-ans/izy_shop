import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../product/data/models/product_model.dart';
import '../../domain/usecases/get_customer_cart.dart';

part 'get_customer_cart_store.g.dart';

@Injectable()
class GetCustomerCartStore = _GetCustomerCartStoreBase
    with _$GetCustomerCartStore;

abstract class _GetCustomerCartStoreBase with Store {
  GetCustomerCart _getCustomerCart;
  _GetCustomerCartStoreBase(
    this._getCustomerCart,
  );

  @observable
  ObservableStream<List<ProductModel>> cartList;

  @action
  execute(String uid) {
    this.cartList = _getCustomerCart(uid).asObservable();
  }
}
