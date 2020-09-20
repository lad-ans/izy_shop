import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/store_model.dart';
import '../repositories/store_repository.dart';

part 'get_store_by_market.g.dart';

abstract class GetStoreByMarket {
  Stream<List<StoreModel>> call(String market);
}

@Injectable()
class GetStoreByMarketImpl implements GetStoreByMarket {
  final StoreRepository _storeRepository;
  GetStoreByMarketImpl(this._storeRepository);

  @override
  Stream<List<StoreModel>> call(String market) {
    return _storeRepository.getStoreByMarket(market);
  }
}
