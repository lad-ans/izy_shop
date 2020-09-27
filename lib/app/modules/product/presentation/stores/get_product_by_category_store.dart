import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/product_model.dart';
import '../../domain/usecases/get_product_by_category.dart';

part 'get_product_by_category_store.g.dart';

@Injectable()
class GetProductByCategoryStore = _GetProductByCategoryStoreBase
    with _$GetProductByCategoryStore;

abstract class _GetProductByCategoryStoreBase with Store {
  final GetProductByCategory getProductByCategory;

  _GetProductByCategoryStoreBase({
    this.getProductByCategory,
  });

  @observable
  ObservableStream<List<ProductModel>> products;

  @action
  execute(DocumentReference reference, List prodCategories) {
    for (var category in prodCategories) {
      this.products =
          getProductByCategory(reference, category).asObservable();
    }
  }
}
