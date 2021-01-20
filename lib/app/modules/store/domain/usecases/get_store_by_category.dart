import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/store_model.dart';
import '../repositories/store_repository.dart';

part 'get_store_by_category.g.dart';

abstract class GetStoreByCategory {
  Stream<List<StoreModel>> call(String market);
}

@Injectable()
class GetStoreByCategoryImpl implements GetStoreByCategory {
  final StoreRepository _storeRepository;
  GetStoreByCategoryImpl(this._storeRepository);

  @override
  Stream<List<StoreModel>> call(String market) {
    return _storeRepository.getStoreByCategory(market);
  }
}
