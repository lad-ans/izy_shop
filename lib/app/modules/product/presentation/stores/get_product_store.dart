import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/product_model.dart';
import '../../domain/usecases/get_product.dart';

part 'get_product_store.g.dart';

@Injectable()
class GetProductStore = _GetProductStoreBase with _$GetProductStore;

abstract class _GetProductStoreBase with Store {
  final GetProduct getProduct;

  _GetProductStoreBase({
    this.getProduct,
  });

  @observable
  ObservableStream<List<ProductModel>> products;

  @action
  execute(DocumentReference reference) {
    this.products = getProduct(reference).asObservable();
  }
}
