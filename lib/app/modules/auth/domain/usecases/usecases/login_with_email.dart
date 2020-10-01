import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/logged_user_info.dart';
import '../../entities/login_credential.dart';
import '../../repositories/loggin_repository.dart';

part 'login_with_email.g.dart';

abstract class LoginWithEmail {
  Future<LoggedUserInfo> call(LoginCredential credential);
}

@Injectable(singleton: false)
class LoginWithEmailImpl implements LoginWithEmail {
  final LoginRepository repository;

  LoginWithEmailImpl(this.repository);

  @override
  Future<LoggedUserInfo> call(LoginCredential credential) async {
    if (!credential.isValidEmail) {
      return null;
    } else if (!credential.isValidPassword) {
      return null;
    }

    return await repository.loginEmail(
      email: credential.email,
      password: credential.password,
    );
  }
}
