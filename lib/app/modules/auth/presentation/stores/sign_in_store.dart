import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../customer/data/models/customer_model.dart';
import '../../domain/usecases/sign_in.dart';

part 'sign_in_store.g.dart';

@Injectable()
class SignInStore = _SignInStoreBase with _$SignInStore;

abstract class _SignInStoreBase with Store {
  SignIn _signIn;
  _SignInStoreBase(
    this._signIn,
  );

  @action
  Future<void> executeSignIn(CustomerModel customerModel, context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(),
    );
    await _signIn(customerModel);
  }
}
