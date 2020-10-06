import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/sign_in_with_google.dart';

part 'sign_in_with_google_store.g.dart';

@Injectable()
class SignInWithGoogleStore = _SignInWithGoogleStoreBase
    with _$SignInWithGoogleStore;

abstract class _SignInWithGoogleStoreBase with Store {
  SignInWithGoogle _signInWithGoogle;
  _SignInWithGoogleStoreBase(
    this._signInWithGoogle,
  );

  Future<void> execute() async {
    return await _signInWithGoogle();
  }
}
