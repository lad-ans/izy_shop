import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/store_model.dart';
import '../../domain/usecases/get_store_by_market.dart';

part 'get_store_by_market_store.g.dart';

@Injectable()
class GetStoreByMarketStore = _GetStoreByMarketStoreBase
    with _$GetStoreByMarketStore;

abstract class _GetStoreByMarketStoreBase with Store {
  final GetStoreByMarket getStoreByMarket;

  _GetStoreByMarketStoreBase({
    this.getStoreByMarket,
  });

  @observable
  ObservableStream<List<StoreModel>> storeList;

  @action
  execute(String market) {
    this.storeList = getStoreByMarket(market).asObservable();
  }
}
