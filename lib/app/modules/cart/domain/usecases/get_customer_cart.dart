import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../product/data/models/product_model.dart';
import '../repositories/cart_repository.dart';

part 'get_customer_cart.g.dart';

abstract class GetCustomerCart {
  Stream<List<ProductModel>> call();
}

@Injectable()
class GetCustomerCartImpl implements GetCustomerCart {
  CartRepository _repository;
  GetCustomerCartImpl(
    this._repository,
  );
  @override
  Stream<List<ProductModel>> call() {
    return _repository.getCustomerCart();
  }
}
