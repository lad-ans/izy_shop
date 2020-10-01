import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/logged_user_info.dart';
import '../../repositories/loggin_repository.dart';

part 'get_logged_user.g.dart';

abstract class GetLoggedUser {
  Future<LoggedUserInfo> call();
}

@Injectable(singleton: false)
class GetLoggedUserImpl implements GetLoggedUser {
  final LoginRepository repository;

  GetLoggedUserImpl(this.repository);

  @override
  Future<LoggedUserInfo> call() async {
    return await repository.loggedUser();
  }
}
