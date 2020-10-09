import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../domain/repositories/store_repository.dart';
import '../models/store_category_model.dart';
import '../models/store_model.dart';

part 'store_repository_impl.g.dart';

@Injectable()
class StoreRepositoryImpl implements StoreRepository {
  final FirebaseFirestore firestore;
  StoreRepositoryImpl(this.firestore);
  @override
  Stream<List<StoreCategoryModel>> getStores() {
    return firestore.collection('storeCategories').snapshots().map((event) {
      try {
        return event.docs.map((doc) {
          return StoreCategoryModel.fromDocument(doc);
        }).toList();
      } catch (error) {
        return error;
      }
    });
  }

  @override
  Stream<List<StoreModel>> getStoreByCategory(String collPath) {
    return firestore
        .collection('stores')
        .doc('5OX5YOeZJAnflZlewMzA')
        .collection(collPath.toLowerCase())
        .snapshots()
        .map((event) {
      try {
        return event.docs.map((doc) {
          return StoreModel.fromDocument(doc);
        }).toList();
      } catch (error) {
        return error;
      }
    });
  }
}
