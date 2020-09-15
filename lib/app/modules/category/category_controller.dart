import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'category_controller.g.dart';

@Injectable()
class CategoryController = _CategoryControllerBase with _$CategoryController;

abstract class _CategoryControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
