import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:izy_shop/app/core/presentation/widgets/loading_dialog.dart';
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

  Future<void> execute(context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(),
    );
    return await _signInWithGoogle();
  }
}
