import 'package:izy_shop/app/modules/store/data/models/store_model.dart';

import '../../data/models/store_category_model.dart';

abstract class StoreRepository {
  Stream<List<StoreCategoryModel>> getStores();
  Stream<List<StoreModel>> getStoreByCategory(String collPath);
}
