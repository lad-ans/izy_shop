import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'product_controller.g.dart';

@Injectable()
class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
