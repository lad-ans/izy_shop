import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/checkout_repository_impl.dart';
import 'domain/usecases/set_order.dart';
import 'presentation/pages/checkout_page.dart';
import 'presentation/pages/maps_page.dart';
import 'presentation/stores/set_order_store.dart';

class CheckoutModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseFirestore.instance),
        $SetOrderImpl,
        $CheckoutRepositoryImpl,
        $SetOrderStore
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => CheckoutPage(routeEntity: args.data)),
        ModularRouter('/maps',
            child: (_, args) => MapsPage(args.data)),
      ];

  static Inject get to => Inject<CheckoutModule>.of();
}
