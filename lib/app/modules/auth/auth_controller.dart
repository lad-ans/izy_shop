import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'domain/entities/login_credential.dart';
import 'domain/usecases/usecases/login_with_email.dart';
import 'presentation/stores/auth_store.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  TextEditingController emailCtrllr = TextEditingController();
  TextEditingController nameCtrllr = TextEditingController();
  TextEditingController passwordCtrllr = TextEditingController();

  final LoginWithEmail loginWithEmailUsecase;
  final AuthStore authStore;

  @observable
  String email = "";

  @action
  setEmail(String value) => this.email = value;

  @observable
  String password = "";
  _AuthControllerBase({
    this.loginWithEmailUsecase,
    this.authStore,
    this.email,
    this.password,
  });

  @action
  setPassword(String value) => this.password = value;

  @computed
  LoginCredential get credential =>
      LoginCredential.withEmailAndPassword(email: email, password: password);

  @computed
  bool get isValid => credential.isValidEmail && credential.isValidPassword;

  enterEmail() async {
    var user = await loginWithEmailUsecase(credential);
    authStore.setUser(user);
  }
}
