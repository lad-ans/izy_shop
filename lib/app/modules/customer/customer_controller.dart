import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'customer_controller.g.dart';

@Injectable()
class CustomerController = _CustomerControllerBase with _$CustomerController;

abstract class _CustomerControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
