import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../customer/data/models/customer_model.dart';
import '../../domain/usecases/sign_up.dart';

part 'sign_up_store.g.dart';

@Injectable()
class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  SignUp _signUp;
  _SignUpStoreBase(
    this._signUp,
  );

  Future<void> executeSignUp(CustomerModel customerModel) async {
    await _signUp(customerModel);
  }
}
