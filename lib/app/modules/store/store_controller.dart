import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'store_controller.g.dart';

@Injectable()
class StoreController = _StoreControllerBase with _$StoreController;

abstract class _StoreControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
