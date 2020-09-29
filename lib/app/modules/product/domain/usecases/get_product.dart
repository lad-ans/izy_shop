import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

part 'get_product.g.dart';

abstract class GetProduct {
  Stream<List<ProductModel>> call(DocumentReference reference);
}

@Injectable()
class GetProductImpl implements GetProduct {
  final ProductRepository _repository;
  GetProductImpl(
    this._repository,
  );
  @override
  Stream<List<ProductModel>> call(DocumentReference reference) {
    return _repository.getProduct(reference);
  }
}
