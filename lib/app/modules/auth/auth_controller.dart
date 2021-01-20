import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordMatcherController = TextEditingController();

  _AuthControllerBase();

  @observable
  String name;

  @action
  setName(String name) => this.name = name;

  @observable
  String surname;

  @action
  setSurname(String surname) => this.surname = surname;

  @observable
  String email;

  @action
  setEmail(String email) => this.email = email;

  @observable
  String password;

  @action
  setPassword(String password) => this.password = password;

  @observable
  String passwordMatcher;

  @action
  setPasswordMatcher(String passwordMatcher) =>
      this.passwordMatcher = passwordMatcher;

  @computed
  bool get matchPassword => this.password == this.passwordMatcher;
}
