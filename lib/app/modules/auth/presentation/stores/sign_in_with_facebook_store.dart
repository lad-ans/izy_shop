import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/sign_in_with_facebook.dart';

part 'sign_in_with_facebook_store.g.dart';

@Injectable()
class SignInWithFacebookStore = _SignInWithFacebookStoreBase
    with _$SignInWithFacebookStore;

abstract class _SignInWithFacebookStoreBase with Store {
  SignInWithFacebook _signInWithFacebook;
  _SignInWithFacebookStoreBase(
    this._signInWithFacebook,
  );

  Future<void> execute() async {
    return await _signInWithFacebook();
  }
}
