import '../../../product/data/models/product_model.dart';

class OrderModel {
  String storeId;
  List<ProductModel> products;
  String location;
  String road;
  String houseNo;
  String instruction;
  String deliveryTime;
  String paymentMethod;
  String customerName;
  num amount;
  String onDeliveryPhone;
  double latitude;
  double longitude;

  OrderModel({
    this.storeId,
    this.products,
    this.location,
    this.road,
    this.houseNo,
    this.instruction,
    this.deliveryTime,
    this.paymentMethod,
    this.customerName,
    this.amount,
    this.onDeliveryPhone,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'products':
          List.from(this.products.map((productModel) => productModel.toMap())),
      'location': this.location,
      'road': this.road,
      'houseNo': this.houseNo,
      'instruction': this.instruction,
      'deliveryTime': this.deliveryTime,
      'paymentMethod': this.paymentMethod,
      'customerName': this.customerName,
      'amount': this.amount,
      'onDeliveryPhone': this.onDeliveryPhone,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'storeId': this.storeId
    };
  }

  @override
  String toString() {
    return '$products, $location, $instruction, $deliveryTime, $paymentMethod, $customerName, $amount, $onDeliveryPhone, $road, $houseNo';
  }
}
