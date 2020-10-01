import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'core/presentation/pages/photo_view_page.dart';
import 'core/presentation/pages/search_page.dart';
import 'modules/auth/auth_module.dart';
import 'modules/cart/cart_module.dart';
import 'modules/cart/data/repositories/cart_repository_impl.dart';
import 'modules/cart/domain/usecases/get_customer_cart.dart';
import 'modules/cart/presentation/stores/cart_module_stores.dart';
import 'modules/checkout/checkout_module.dart';
import 'modules/customer/customer_module.dart';
import 'modules/home/home_module.dart';
import 'modules/product/data/repositories/product_repository_impl.dart';
import 'modules/product/domain/usecases/product_module_usecases.dart';
import 'modules/product/presentation/stores/product_module_stores.dart';
import 'modules/store/store_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        /// core
        $AppController,
        Bind((i) => FirebaseFirestore.instance),

        /// product module
        $ProductRepositoryImpl,
        $GetProductStore,
        $GetProductImpl,
        $AddToCartStore,
        $AddToCartImpl,

        /// cart module
        $CartStore,
        $GetCustomerCartStore,
        $GetCustomerCartImpl,
        $CartRepositoryImpl
      ];

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
        ModularRouter('/search', child: (_, args) => SearchPage(args.data)),
        ModularRouter('/photo-view',
            child: (_, args) => PhotoViewPage(args.data)),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
