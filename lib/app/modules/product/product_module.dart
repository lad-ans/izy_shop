import 'package:izy_shop/app/modules/store/presentation/stores/get_market_store.dart';

import 'product_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'product_page.dart';

class ProductModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ProductController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ProductPage()),
      ];

  static Inject get to => Inject<ProductModule>.of();
}
