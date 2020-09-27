import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../product/data/models/product_model.dart';
import '../../domain/repositories/cart_repository.dart';

part 'cart_repository_impl.g.dart';

@Injectable()
class CartRepositoryImpl implements CartRepository {
  Firestore firestore;
  CartRepositoryImpl({
    this.firestore,
  });
  @override
  Stream<List<ProductModel>> getCustomerCart(String uuid) {
    return firestore
        .collection('customers')
        .document('n020rrAhbe6AoaURdrza')
        .collection('cart')
        .snapshots()
        .map((snap) {
      return snap.documents.map((doc) {
        return ProductModel.fromDocument(doc);
      }).toList();
    });
  }
}
