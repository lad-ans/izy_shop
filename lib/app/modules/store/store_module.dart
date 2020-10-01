import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/shopping_page.dart';
import 'presentation/stores/get_store_by_market_store.dart';
import 'presentation/pages/store_page.dart';

class StoreModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseFirestore.instance),
        $GetStoreByCategoryStore,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => StorePage(args.data)),
        ModularRouter('/shopping', child: (_, args) => ShoppingPage(args.data)),
      ];

  static Inject get to => Inject<StoreModule>.of();
}
