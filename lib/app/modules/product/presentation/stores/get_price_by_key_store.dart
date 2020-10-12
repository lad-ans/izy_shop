import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';
part 'get_price_by_key_store.g.dart';

@Injectable()
class GetPriceByKeyStore = _GetPriceByKeyStoreBase with _$GetPriceByKeyStore;

abstract class _GetPriceByKeyStoreBase with Store {
  @observable
  num customPrice = 0;

  @observable
  String isSelected = '';

  @action
  selectKey(String key, Map<String, dynamic> map) {
    this.isSelected = key;
    this.customPrice = map[key];
  }
}
