import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../store/data/repositories/store_repository_impl.dart';
import '../store/domain/usecases/get_market.dart';
import '../store/domain/usecases/get_store_by_market.dart';
import '../store/presentation/stores/get_market_store.dart';
import '../store/presentation/stores/get_store_by_market_store.dart';
import 'home_controller.dart';
import 'home_page.dart';
import 'presentation/pages/city_selection_page.dart';
import 'presentation/pages/market_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
        Bind((i) => Firestore()),
        $StoreRepositoryImpl,
        $GetMarketImpl,
        $GetStoreByMarketStore,
        $GetStoreByMarketImpl,
        $GetMarketStore,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/city', child: (_, args) => CitySelectionPage()),
        ModularRouter('/market',
            child: (_, args) => MarketPage(args.data)),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
