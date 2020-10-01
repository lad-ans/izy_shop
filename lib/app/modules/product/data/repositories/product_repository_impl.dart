import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';
part 'product_repository_impl.g.dart';

@Injectable()
class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore flutterFire;
  ProductRepositoryImpl({
    this.flutterFire,
  });

  @override
  Stream<List<ProductModel>> getProduct(DocumentReference reference) {
    return reference.collection('products').snapshots().map((snap) {
      return snap.docs.map((doc) {
        return ProductModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Future<void> addToCart(ProductModel productModel) async {
    CollectionReference _collRef = flutterFire
        .collection('customers')
        .doc('n020rrAhbe6AoaURdrza')
        .collection('cart');

    await _collRef.add(
      productModel.toMap(),
    );
  }
}
