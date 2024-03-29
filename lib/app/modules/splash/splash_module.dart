import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/modules/splash/presentation/splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers =>
      [ModularRouter('/', child: (_, args) => SplashPage())];

  static Inject get to => Inject<SplashModule>.of();
}
