import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/modules/auth/presentation/pages/action_page.dart';
import 'package:izy_shop/app/modules/auth/presentation/pages/signup_page.dart';

import 'auth_controller.dart';
import 'presentation/pages/login_page.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [$AuthController];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ActionPage()),
        ModularRouter('/login', child: (_, args) => LoginPage()),
        ModularRouter('/signup', child: (_, args) => SignUpPage()),
      ];

  static Inject get to => Inject<AuthModule>.of();
}
