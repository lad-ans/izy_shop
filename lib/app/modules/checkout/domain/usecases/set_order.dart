import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/order_model.dart';
import '../repositories/checkout_repository.dart';
part 'set_order.g.dart';

abstract class SetOrder {
  Future<bool> call(OrderModel orderModel);
}

@Injectable()
class SetOrderImpl implements SetOrder {
  final CheckoutRepository _repository;
  SetOrderImpl(
    this._repository,
  );
  @override
  Future<bool> call(OrderModel orderModel) async {
    return await _repository.setOrder(orderModel);
  }
}
