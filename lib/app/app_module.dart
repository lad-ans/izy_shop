import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/core/presentation/pages/search_page.dart';
import 'package:izy_shop/app/modules/auth/auth_module.dart';
import 'package:izy_shop/app/modules/cart/cart_module.dart';
import 'package:izy_shop/app/modules/checkout/checkout_module.dart';
import 'package:izy_shop/app/modules/customer/customer_module.dart';
import 'package:izy_shop/app/modules/store/store_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [$AppController];

  @override
  List<ModularRouter> get routers => [
        /// modules
        ModularRouter(Modular.initialRoute, module: AuthModule()),
        ModularRouter('/auth', module: AuthModule()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/store', module: StoreModule()),
        ModularRouter('/cart', module: CartModule()),
        ModularRouter('/checkout', module: CheckoutModule()),
        ModularRouter('/customer', module: CustomerModule()),

        /// pages
        ModularRouter('/search', child: (_, args) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
