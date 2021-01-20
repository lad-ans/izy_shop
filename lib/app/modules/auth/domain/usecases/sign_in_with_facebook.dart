import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../repositories/auth_repository.dart';

part 'sign_in_with_facebook.g.dart';

abstract class SignInWithFacebook {
  Future<void> call();
}

@Injectable()
class SignInWithFacebookImpl implements SignInWithFacebook {
  AuthRepository _repository;

  SignInWithFacebookImpl(
    this._repository,
  );

  @override
  Future<void> call() async {
    await _repository.signInWithFacebook();
  }
}
