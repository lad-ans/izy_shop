import '../../../product/data/models/product_model.dart';

class OrderModel {
  List<ProductModel> products;
  String location;
  String instruction;
  String deliveryTime;
  String paymentMethod;
  String customerName;
  num amount;
  String onDeliveryPhone;

  OrderModel({
    this.products,
    this.location,
    this.instruction,
    this.deliveryTime,
    this.paymentMethod,
    this.customerName,
    this.amount,
    this.onDeliveryPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      'products':
          List.from(this.products.map((productModel) => productModel.toMap())),
      'location': this.location,
      'instruction': this.instruction,
      'deliveryTime': this.deliveryTime,
      'paymentMethod': this.paymentMethod,
      'customerName': this.customerName,
      'amount': this.amount,
      'onDeliveryPhone': this.onDeliveryPhone,
    };
  }

  @override
  String toString() {
    return '$products, $location, $instruction, $deliveryTime, $paymentMethod, $customerName, $amount, $onDeliveryPhone';
  }
}
