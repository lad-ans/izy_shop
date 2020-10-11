import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/remove_all_cart.dart';

part 'remove_all_store.g.dart';

@Injectable()
class RemoveAllCartStore = _RemoveAllCartStoreBase with _$RemoveAllCartStore;

abstract class _RemoveAllCartStoreBase with Store {
  final RemoveAllCart _removeAllCart;

  _RemoveAllCartStoreBase(this._removeAllCart);

  void execute() {
    _removeAllCart();
  }
}
