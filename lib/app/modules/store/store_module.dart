import 'package:izy_shop/app/modules/store/presentation/pages/pages/shopping_page.dart';
import 'package:izy_shop/app/modules/store/presentation/stores/get_market_store.dart';

import 'store_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'store_page.dart';

class StoreModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $StoreController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => StorePage()),
        ModularRouter('/shopping', child: (_, args) => ShoppingPage()),
      ];

  static Inject get to => Inject<StoreModule>.of();
}
