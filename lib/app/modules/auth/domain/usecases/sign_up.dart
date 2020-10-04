import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../customer/data/models/customer_model.dart';
import '../repositories/auth_repository.dart';

part 'sign_up.g.dart';

abstract class SignUp {
  Future<void> call(CustomerModel customerModel);
}

@Injectable()
class SignUpImpl implements SignUp {
  AuthRepository _authRepository;
  SignUpImpl(
    this._authRepository,
  );
  @override
  Future<void> call(CustomerModel customerModel) async {
    await _authRepository.signUp(customerModel);
  }
}
