import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/presentation/widgets/loading_dialog.dart';
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

  Future<void> execute(context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(),
    );
    return await _signInWithFacebook();
  }
}
