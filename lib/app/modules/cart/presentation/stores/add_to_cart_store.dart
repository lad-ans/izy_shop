import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../../product/data/models/product_model.dart';
import '../../domain/usecases/add_to_cart.dart';

part 'add_to_cart_store.g.dart';

@Injectable()
class AddToCartStore = _AddToCartStoreBase with _$AddToCartStore;

abstract class _AddToCartStoreBase with Store {
  final AddToCart _addToCart;

  _AddToCartStoreBase(this._addToCart);

  @action
  void execute(ProductModel productModel) {
    _addToCart(productModel);
  }

  @observable
  Color dragFeedbackColor = Colors.transparent;

  @action
  setDragFeedbackColor(Color color) {
    this.dragFeedbackColor = color;
  }
}
