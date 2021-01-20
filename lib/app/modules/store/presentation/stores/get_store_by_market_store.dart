import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/store_model.dart';
import '../../domain/usecases/get_store_by_category.dart';

part 'get_store_by_market_store.g.dart';

@Injectable()
class GetStoreByCategoryStore = _GetStoreByCategoryStoreBase
    with _$GetStoreByCategoryStore;

abstract class _GetStoreByCategoryStoreBase with Store {
  final GetStoreByCategory getStoreByCategory;

  _GetStoreByCategoryStoreBase({
    this.getStoreByCategory,
  });

  @observable
  ObservableStream<List<StoreModel>> storeList;

  @action
  execute(String market) {
    this.storeList = getStoreByCategory(market).asObservable();
  }
}
