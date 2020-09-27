import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

part 'get_product_by_category.g.dart';

abstract class GetProductByCategory {
  Stream<List<ProductModel>> call(
      DocumentReference reference, String category);
}

@Injectable()
class GetProductByCategoryImpl implements GetProductByCategory {
  final ProductRepository _repository;
  GetProductByCategoryImpl(this._repository);
  @override
  Stream<List<ProductModel>> call(
      DocumentReference reference, String category) {
    return _repository.getProductByCategory(reference, category);
  }
}
