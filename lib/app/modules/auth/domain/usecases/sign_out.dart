import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../repositories/auth_repository.dart';
part 'sign_out.g.dart';

abstract class SignOut {
  Future<void> call();
}

@Injectable()
class SignOutImpl implements SignOut {
  AuthRepository _authRepository;
  SignOutImpl(
    this._authRepository,
  );
  @override
  Future<void> call() async {
    await _authRepository.signOut();
  }
}
