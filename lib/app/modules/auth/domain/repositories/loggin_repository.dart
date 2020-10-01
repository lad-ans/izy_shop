import '../entities/logged_user_info.dart';

abstract class LoginRepository {
  Future<LoggedUserInfo> loginEmail({String email, String password});
  Future<LoggedUserInfo> loggedUser();
  Future<void> logout();
}
