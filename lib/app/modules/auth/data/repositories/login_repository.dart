import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../domain/entities/logged_user_info.dart';
import '../../domain/repositories/loggin_repository.dart';
import '../datasources/login_datasource.dart';

@Injectable(singleton: false)
class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<LoggedUserInfo> loginEmail({String email, String password}) async {
    try {
      var user = await dataSource.loginEmail(email: email, password: password);
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<LoggedUserInfo> loggedUser() async {
    try {
      var user = await dataSource.currentUser();
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dataSource.logout();
    } catch (e) {
      return null;
    }
  }
}
