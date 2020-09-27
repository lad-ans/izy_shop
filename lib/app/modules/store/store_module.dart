import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/shopping_page.dart';
import 'presentation/stores/get_store_by_market_store.dart';
import 'store_controller.dart';
import 'store_page.dart';

class StoreModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $StoreController,
        Bind((i) => Firestore()),
        $GetStoreByMarketStore,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => StorePage()),
        ModularRouter('/shopping', child: (_, args) => ShoppingPage(args.data)),
      ];

  static Inject get to => Inject<StoreModule>.of();
}
