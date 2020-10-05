import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/customer_model.dart';
import '../repositories/customer_repository.dart';

part 'get_logged_customer.g.dart';

abstract class GetLoggedCustomer {
  Stream<CustomerModel> call(String uid);
}

@Injectable()
class GetLoggedCustomerImpl implements GetLoggedCustomer {
  CustomerRepository _repository;
  GetLoggedCustomerImpl(
    this._repository,
  );
  @override
  Stream<CustomerModel> call(String uid) {
    return _repository.getLoggedCustomer(uid);
  }
}
