import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../repositories/auth_repository.dart';

part 'sign_in_with_google.g.dart';

abstract class SignInWithGoogle {
  Future<void> call();
}

@Injectable()
class SignInWithGoogleImpl implements SignInWithGoogle {
  AuthRepository _repository;

  SignInWithGoogleImpl(
    this._repository,
  );

  @override
  Future<void> call() async {
    await _repository.signInWithGoogle();
  }
}
