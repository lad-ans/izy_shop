import 'checkout_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'checkout_page.dart';

class CheckoutModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CheckoutController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => CheckoutPage(routeEntity: args.data)),
      ];

  static Inject get to => Inject<CheckoutModule>.of();
}
