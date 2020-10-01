import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/market_model.dart';
import '../../domain/usecases/get_store.dart';

part 'get_market_store.g.dart';

@Injectable()
class GetStoreStore = _GetStoreStoreBase with _$GetStoreStore;

abstract class _GetStoreStoreBase with Store {
  final GetStore getStore;

  _GetStoreStoreBase({this.getStore}) {
    execute();
  }

  @observable
  ObservableStream<List<MarketModel>> marketList;

  @action
  execute() {
    this.marketList = getStore().asObservable();
  }
}
