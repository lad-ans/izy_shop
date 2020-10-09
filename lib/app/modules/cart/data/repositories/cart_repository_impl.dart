import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:izy_shop/app/modules/customer/domain/entities/logged_user.dart';

import '../../../product/data/models/product_model.dart';
import '../../domain/repositories/cart_repository.dart';

part 'cart_repository_impl.g.dart';

@Injectable()
class CartRepositoryImpl implements CartRepository {
  FirebaseFirestore firestore;
  CartRepositoryImpl({
    this.firestore,
  });
  @override
  Stream<List<ProductModel>> getCustomerCart() {
    return firestore
        .collection('customers')
        .doc(LoggedUser.instance.loggedUserUid)
        .collection('cart')
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return ProductModel.fromDocument(doc);
      }).toList();
    });
  }
}
