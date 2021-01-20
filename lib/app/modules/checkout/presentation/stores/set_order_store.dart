import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/order_model.dart';
import '../../domain/usecases/set_order.dart';

part 'set_order_store.g.dart';

@Injectable()
class SetOrderStore = _SetOrderStoreBase with _$SetOrderStore;

abstract class _SetOrderStoreBase with Store {
  final SetOrder _setOrder;

  _SetOrderStoreBase(
    this._setOrder,
  );


  @action
  execute(OrderModel orderModel) async {
    await _setOrder(orderModel);
  }
}
