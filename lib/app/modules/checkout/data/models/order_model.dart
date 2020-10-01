import '../../../customer/data/models/customer_model.dart';
import '../../../product/data/models/product_model.dart';

class OrderModel {
  List<ProductModel> products;
  String location;
  String instruction;
  String deliveryTime;
  String paymentMethod;
  CustomerModel customer;
  num amount;
  String onDeliveryPhone;

  OrderModel({
    this.products,
    this.location,
    this.instruction,
    this.deliveryTime,
    this.paymentMethod,
    this.customer,
    this.amount,
    this.onDeliveryPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      'products': List.from(
          this.products.map((productModel) => productModel.toMap())),
      'location': this.location,
      'instruction': this.instruction,
      'deliveryTime': this.deliveryTime,
      'paymentMethod': this.paymentMethod,
      'customer': this.customer,
      'amount': this.amount,
      'onDeliveryPhone': this.onDeliveryPhone,
    };
  }

  @override
  String toString() {
    return '$products, $location, $instruction, $deliveryTime, $paymentMethod, $customer, $amount, $onDeliveryPhone';
  }
}
