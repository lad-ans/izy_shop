import 'package:izy_shop/app/modules/customer/presentation/pages/account/account_page.dart';

import 'customer_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'customer_page.dart';

class CustomerModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CustomerController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AccountPage()),
      ];

  static Inject get to => Inject<CustomerModule>.of();
}
