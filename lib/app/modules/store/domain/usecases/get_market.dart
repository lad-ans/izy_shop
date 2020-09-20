import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/market_model.dart';
import '../repositories/store_repository.dart';
part 'get_market.g.dart';

abstract class GetMarket {
  Stream<List<MarketModel>> call();
}

@Injectable()
class GetMarketImpl implements GetMarket {
  final StoreRepository _storeRepository;
  GetMarketImpl(this._storeRepository);

  @override
  Stream<List<MarketModel>> call() {
    return _storeRepository.getMarkets();
  }
}
