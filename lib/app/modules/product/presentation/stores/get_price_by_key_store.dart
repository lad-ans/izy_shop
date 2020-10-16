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
  String keyReceiver = '';

  @observable
  String selectedCustomPriceKey;

  @observable
  num selectedCustomPriceValue;

  @observable
  Map<String, dynamic> selectedItem;

  @action
  selectKey(String key, Map<String, dynamic> map) {
    this.keyReceiver = key;

    this.selectedCustomPriceKey = key;
    this.selectedCustomPriceValue = map[key];

    /// set custom price
    this.customPrice = map[key];
  }

  selectItem() {
    this.selectedItem = {
      this.selectedCustomPriceKey: this.selectedCustomPriceValue
    };
  }

  @action
  void resetSelectedItem() {
    this.customPrice = 0;
    this.keyReceiver = '';
    this.selectedCustomPriceKey = 'empty';
    this.selectedCustomPriceValue = null;
  }
}
