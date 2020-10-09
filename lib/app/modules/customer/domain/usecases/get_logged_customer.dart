import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/customer_model.dart';
import '../repositories/customer_repository.dart';

part 'get_logged_customer.g.dart';

abstract class GetLoggedCustomer {
  Stream<CustomerModel> call();
}

@Injectable()
class GetLoggedCustomerImpl implements GetLoggedCustomer {
  CustomerRepository _repository;
  GetLoggedCustomerImpl(
    this._repository,
  );
  @override
  Stream<CustomerModel> call() {
    return _repository.getLoggedCustomer();
  }
}
