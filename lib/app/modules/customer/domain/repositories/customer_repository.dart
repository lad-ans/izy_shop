import '../../data/models/customer_model.dart';

abstract class CustomerRepository {
  Stream<CustomerModel> getLoggedCustomer();
}
