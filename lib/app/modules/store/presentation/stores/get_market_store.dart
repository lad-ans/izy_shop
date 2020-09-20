import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/market_model.dart';
import '../../domain/usecases/get_market.dart';

part 'get_market_store.g.dart';

@Injectable()
class GetMarketStore = _GetMarketStoreBase with _$GetMarketStore;

abstract class _GetMarketStoreBase with Store {
  final GetMarket getStore;

  _GetMarketStoreBase({this.getStore}) {
    execute();
  }

  @observable
  ObservableStream<List<MarketModel>> marketList;

  @action
  execute() {
    this.marketList = getStore().asObservable();
  }
}
