import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../domain/repositories/checkout_repository.dart';
import '../models/order_model.dart';
part 'checkout_repository_impl.g.dart';

@Injectable()
class CheckoutRepositoryImpl implements CheckoutRepository {
  final FirebaseFirestore firestore;
  CheckoutRepositoryImpl({
    this.firestore,
  });
  @override
  Future<bool> setOrder(OrderModel orderModel) async {
    try {
      await firestore.collection('orders').add(orderModel.toMap());
      print('success written');
      return true;
    } catch (error) {
      print(error);
      print('fail on write data');
      return false;
    }
  }
}
