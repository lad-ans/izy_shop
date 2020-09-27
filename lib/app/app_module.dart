import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/modules/cart/data/repositories/cart_repository_impl.dart';
import 'package:izy_shop/app/modules/cart/domain/usecases/get_customer_cart.dart';
import 'package:izy_shop/app/modules/cart/presentation/stores/get_customer_cart_store.dart';
import 'package:izy_shop/app/modules/product/data/repositories/product_repository_impl.dart';
import 'package:izy_shop/app/modules/product/domain/usecases/add_to_cart.dart';
import 'package:izy_shop/app/modules/product/domain/usecases/get_product_by_category.dart';
import 'package:izy_shop/app/modules/product/presentation/stores/add_to_cart_store.dart';
import 'package:izy_shop/app/modules/product/presentation/stores/get_product_by_category_store.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'core/presentation/pages/search_page.dart';
import 'modules/auth/auth_module.dart';
import 'modules/cart/cart_module.dart';
import 'modules/checkout/checkout_module.dart';
import 'modules/customer/customer_module.dart';
import 'modules/home/home_module.dart';
import 'modules/store/store_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        /// core
        $AppController,
        Bind((i) => Firestore()),

        /// product module
        $ProductRepositoryImpl,
        $GetProductByCategoryStore,
        $GetProductByCategoryImpl,
        $AddToCartStore,
        $AddToCartImpl,

        /// cart module
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
        ModularRouter('/search', child: (_, args) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
