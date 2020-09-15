import 'package:izy_shop/app/modules/home/presentation/pages/city_selection_page.dart';
import 'package:izy_shop/app/modules/home/presentation/pages/market_page.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/city', child: (_, args) => CitySelectionPage()),
        ModularRouter('/market', child: (_, args) => MarketPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
