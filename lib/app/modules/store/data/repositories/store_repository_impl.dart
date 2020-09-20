import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../domain/repositories/store_repository.dart';
import '../models/market_model.dart';
import '../models/store_model.dart';

part 'store_repository_impl.g.dart';

@Injectable()
class StoreRepositoryImpl implements StoreRepository {
  final Firestore firestore;
  StoreRepositoryImpl(this.firestore);
  @override
  Stream<List<MarketModel>> getMarkets() {
    return firestore.collection('list').snapshots().map((event) {
      try {
        return event.documents.map((doc) {
          return MarketModel.fromDocument(doc);
        }).toList();
      } catch (error) {
        return error;
      }
    });
  }

  @override
  Stream<List<StoreModel>> getStoreByMarket(String collPath) {
    print(collPath);
    return firestore
        .collection('market')
        .document('5OX5YOeZJAnflZlewMzA')
        .collection(collPath.toLowerCase())
        .snapshots()
        .map((event) {
      try {
        return event.documents.map((doc) {
          return StoreModel.fromDocument(doc);
        }).toList();
      } catch (error) {
        return error;
      }
    });
  }
}
