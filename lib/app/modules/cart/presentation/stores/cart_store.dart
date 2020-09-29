import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

@Injectable()
class CartStore = _CartStoreBase with _$CartStore;

abstract class _CartStoreBase with Store {}
