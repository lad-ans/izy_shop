import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

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

  Future<void> executeSignIn(CustomerModel customerModel) async {
    await _signIn(customerModel);
  }
}
