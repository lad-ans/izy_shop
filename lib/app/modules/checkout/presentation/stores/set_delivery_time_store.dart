import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';
part 'set_delivery_time_store.g.dart';

@Injectable()
class SetDeliveryTimeStore = _SetDeliveryTimeStoreBase
    with _$SetDeliveryTimeStore;

abstract class _SetDeliveryTimeStoreBase with Store {
  @observable
  String deliveryTime;

  @action
  setDeliveryTime(String time) => this.deliveryTime = time;
}
