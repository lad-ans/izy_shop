import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../product/data/models/product_model.dart';
import '../../domain/usecases/get_cart.dart';

part 'get_cart_store.g.dart';

@Injectable()
class GetCartStore = _GetCartStoreBase with _$GetCartStore;

abstract class _GetCartStoreBase with Store {
  final GetCart _getCart;

  _GetCartStoreBase(this._getCart);

  @observable
  ObservableList<ProductModel> cartList = ObservableList<ProductModel>();

  @action
  execute() {
    cartList = _getCart().asObservable();
  }
}
