import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

part 'add_to_cart.g.dart';

abstract class AddToCart {
  Future<void> call(ProductModel productModel);
}

@Injectable()
class AddToCartImpl implements AddToCart {
  ProductRepository _repository;
  AddToCartImpl(
    this._repository,
  );
  @override
  Future<void> call(ProductModel productModel) async {
    _repository.addToCart(productModel);
  }
}
