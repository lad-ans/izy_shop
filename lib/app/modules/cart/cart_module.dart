import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/cart_page.dart';


class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => CartPage(routeEntity: args.data)),
      ];

  static Inject get to => Inject<CartModule>.of();
}
