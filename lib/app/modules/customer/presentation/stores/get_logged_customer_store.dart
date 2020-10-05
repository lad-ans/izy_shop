import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/customer_model.dart';
import '../../domain/usecases/get_logged_customer.dart';

part 'get_logged_customer_store.g.dart';

@Injectable()
class GetLoggedCustomerStore = _GetLoggedCustomerStoreBase
    with _$GetLoggedCustomerStore;

abstract class _GetLoggedCustomerStoreBase with Store {
  GetLoggedCustomer _getLoggedCustomer;
  _GetLoggedCustomerStoreBase(
    this._getLoggedCustomer,
  );

  @observable
  ObservableStream<CustomerModel> currentCustomer;

  @action
  execute(String uid) =>
      this.currentCustomer = _getLoggedCustomer(uid).asObservable();
}
