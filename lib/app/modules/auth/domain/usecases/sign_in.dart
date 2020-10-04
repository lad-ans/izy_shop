import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../customer/data/models/customer_model.dart';
import '../repositories/auth_repository.dart';
part 'sign_in.g.dart';

abstract class SignIn {
  Future<void> call(CustomerModel customerModel);
}

@Injectable()
class SignInImpl implements SignIn {
  AuthRepository _authRepository;
  SignInImpl(
    this._authRepository,
  );
  @override
  Future<void> call(CustomerModel customerModel) async {
    await _authRepository.signIn(customerModel);
  }
}
