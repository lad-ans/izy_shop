import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/loggin_repository.dart';

part 'logout.g.dart';

abstract class Logout {
  Future<void> call();
}

@Injectable(singleton: false)
class LogoutImpl implements Logout {
  final LoginRepository repository;

  LogoutImpl(this.repository);

  @override
  Future<void> call() async {
    return await repository.logout();
  }
}
