import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../product/data/models/product_model.dart';

part 'cart_data_source.g.dart';

@Injectable()
class CartDataSource = _CartDataSourceBase with _$CartDataSource;

abstract class _CartDataSourceBase with Store {
  @observable
  ObservableList<ProductModel> customerCart =
      ObservableList<ProductModel>().asObservable();

  @action
  void addToCart(ProductModel productModel) {
    customerCart.add(productModel);
  }

  @action
  void removeFromCart(ProductModel productModel) {
    customerCart.remove(productModel);
  }

  @action
  void removeAll() {
    customerCart.clear();
  }
}
