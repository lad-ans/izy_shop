import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  TextEditingController emailCtrllr = TextEditingController();
  TextEditingController nameCtrllr = TextEditingController();
  TextEditingController passwordCtrllr = TextEditingController();
}
