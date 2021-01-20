import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/store_category_model.dart';
import '../repositories/store_repository.dart';
part 'get_store.g.dart';

abstract class GetStore {
  Stream<List<StoreCategoryModel>> call();
}

@Injectable()
class GetStoreImpl implements GetStore {
  final StoreRepository _storeRepository;
  GetStoreImpl(this._storeRepository);

  @override
  Stream<List<StoreCategoryModel>> call() {
    return _storeRepository.getStores();
  }
}
