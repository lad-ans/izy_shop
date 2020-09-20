import 'package:izy_shop/app/modules/store/data/models/store_model.dart';

import '../../data/models/market_model.dart';

abstract class StoreRepository {
  Stream<List<MarketModel>> getMarkets();
  Stream<List<StoreModel>> getStoreByMarket(String collPath);
}