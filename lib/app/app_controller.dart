import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  int selectedIndex;

  @action
  select(int index, {bool isFixed = false}) {
    this.selectedIndex = index;
    if (!isFixed) {
      Future.delayed(Duration(milliseconds: 500), () {
        this.selectedIndex = -1;
      });
    }
  }
}
