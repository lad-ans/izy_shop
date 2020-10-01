import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/market_model.dart';
import '../repositories/store_repository.dart';
part 'get_store.g.dart';

abstract class GetStore {
  Stream<List<MarketModel>> call();
}

@Injectable()
class GetStoreImpl implements GetStore {
  final StoreRepository _storeRepository;
  GetStoreImpl(this._storeRepository);

  @override
  Stream<List<MarketModel>> call() {
    return _storeRepository.getStores();
  }
}
