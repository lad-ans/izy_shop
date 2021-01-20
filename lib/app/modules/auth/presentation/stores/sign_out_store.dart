import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/sign_out.dart';

part 'sign_out_store.g.dart';

@Injectable()
class SignOutStore = _SignOutStoreBase with _$SignOutStore;

abstract class _SignOutStoreBase with Store {
  SignOut _signOut;
  _SignOutStoreBase(
    this._signOut,
  );

  Future<void> executeSignOut() async {
    await _signOut();
  }
}
