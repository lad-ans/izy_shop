import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/account/account_page.dart';

class CustomerModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AccountPage()),
      ];

  static Inject get to => Inject<CustomerModule>.of();
}
