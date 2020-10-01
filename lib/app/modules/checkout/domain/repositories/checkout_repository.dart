import '../../data/models/order_model.dart';

abstract class CheckoutRepository {
  Future<bool> setOrder(OrderModel orderModel);
}
