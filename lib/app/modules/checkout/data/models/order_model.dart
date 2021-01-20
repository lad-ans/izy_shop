import 'dart:async';
import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../../core/domain/consts/credential.dart';
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
  num deliveryAmount;
  num subtotal;
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
    this.deliveryAmount,
    this.subtotal,
    this.onDeliveryPhone,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'products': List.from(
        this.products.map((productModel) => productModel.toMap()),
      ),
      'location': this.location,
      'road': this.road,
      'houseNo': this.houseNo,
      'instruction': this.instruction,
      'deliveryAmount': this.deliveryAmount,
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

  Future<void> sendOrderReport(File orderReportFile) async {
    final smtpServer = gmail(EMAIL_USERNAME, EMAIL_PASSWORD);

    final message = Message()
      ..from = Address(EMAIL_USERNAME, 'Izy Shop Mobile App')
      ..recipients.add(EMAIL_RECIPIENT)
      ..subject = 'Relatório de encomenda'
      ..text = 'Encomenda efectuada em ${DateTime.now().toString()}'
      ..attachments.add(FileAttachment(orderReportFile));

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. ${e.toString()}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  String toString() {
    return '$products, $location, $instruction, $deliveryTime, $paymentMethod, $customerName, $amount, $onDeliveryPhone, $road, $houseNo $deliveryAmount $subtotal';
  }
}
