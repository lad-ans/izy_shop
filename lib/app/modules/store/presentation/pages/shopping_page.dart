import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/domain/entities/route_entity.dart';
import '../../../../core/presentation/widgets/custom_statusbar.dart';
import '../../../../core/presentation/widgets/shopping_appbar.dart';
import '../../../cart/data/datasources/cart_data_source.dart';
import '../../../cart/presentation/stores/add_to_cart_store.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/presentation/widgets/item_tile.dart';
import '../../../product/presentation/widgets/product_list.dart';

class ShoppingPage extends StatefulWidget {
  final RouteEntity routeEntity;
  const ShoppingPage(this.routeEntity);
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final _cartDataSource = Modular.get<CartDataSource>();

  @override
  void initState() {
    setLandscapeOrientation();
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      height: getHeight(context),
      child: Stack(
        children: [
          SizedBox(height: getStatusBar(context)),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 75 + getStatusBar(context)),
              child: Column(
                  children: widget?.routeEntity?.productCategories?.map(
                        (productCategory) {
                          return ProductList(
                            routeEntity: widget.routeEntity,
                            listTitle: productCategory,
                          );
                        },
                      )?.toList() ??
                      <Widget>[Center(child: Text('No Items!'))]),
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
              padding: EdgeInsets.only(top: getStatusBar(context)),
              child: ShoppingAppBar(
                onBack: true,
                onNavigate: true,
                routeEntity: widget.routeEntity,
              )),
          Positioned(bottom: 0.0, child: _buildBottomNavBar(context))
        ],
      ),
    );
  }

  _buildBottomNavBar(BuildContext context) {
    return Container(
      width: getWidth(context),
      height: 60.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildListItem()),
          _buildCartTile(context),
        ],
      ),
    );
  }

  _buildListItem() {
    return Observer(builder: (_) {
      List<ProductModel> cartList = Modular.get<CartDataSource>().customerCart;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          ProductModel productModel = cartList[index];
          return ItemTile(
            itemWidth: 60.0,
            isOnBasket: true,
            color: Theme.of(context).cardColor,
            productModel: productModel,
            showItemPrice: false,
          );
        },
      );
    });
  }

  _buildCartTile(BuildContext context) {
    return Observer(builder: (_) {
      List<ProductModel> cartList = _cartDataSource.customerCart;
      return DragTarget<ProductModel>(
        builder: (context, incoming, rejected) {
          return InkWell(
            onTap: () async {
              setAllOrientations();
              await Modular.to.pushNamed(
                '/cart',
                arguments: RouteEntity(
                  storeImg: widget.routeEntity.storeImg,
                ),
              );
              setLandscapeOrientation();
            },
            child: Material(
              color: Colors.green[200],
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(40.0))),
              child: Container(
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(40.0)),
                ),
                height: 60.0,
                width: 130.0,
                child: _buildCart(),
              ),
            ),
          );
        },
        onWillAccept: (ProductModel productModel) {
          Modular.get<AddToCartStore>().setDragFeedbackColor(Colors.red[300]);
          return true;
        },
        onAccept: (ProductModel productModel) {
          Modular.get<AddToCartStore>()
              .setDragFeedbackColor(Colors.transparent);
          List<ProductModel> tempList = [];
          tempList.addAll(
              cartList?.where((e) => e.id == productModel.id)?.toList());
          if (LoggedUser.instance.loggedUserUid != null) {
            if (tempList.length == 0) {
              _cartDataSource.addToCart(productModel);
            } else {
              EdgeAlert.show(
                context,
                title: 'Product exists',
                description: 'This product already exists on your cart!',
                gravity: EdgeAlert.TOP,
                icon: Icons.info,
                backgroundColor: Colors.amber.withOpacity(0.8),
                duration: EdgeAlert.LENGTH_SHORT,
              );
            }
          } else {
            EdgeAlert.show(
              context,
              title: 'No user found',
              description: 'Login to buy item',
              gravity: EdgeAlert.BOTTOM,
              icon: Icons.info,
              backgroundColor: Colors.redAccent,
              duration: EdgeAlert.LENGTH_SHORT,
            );
          }
        },
        onLeave: (productModel) {
          Modular.get<AddToCartStore>()
              .setDragFeedbackColor(Colors.transparent);
        },
      );
    });
  }

  _buildCart() {
    return Observer(builder: (_) {
      List<ProductModel> cartList = _cartDataSource.customerCart;
      return Container(
        alignment: Alignment.center,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            cartList.length > 0
                ? Icon(
                    Icons.add_shopping_cart,
                    size: 40,
                    color: Colors.white,
                  )
                : Image.asset(DRAG_DROP, height: 40.0),
            Positioned(
              top: -8.0,
              right: -5.0,
              child: Visibility(
                visible: cartList.length != 0,
                child: _buildCartCount(),
              ),
            ),
          ],
        ),
      );
    });
  }

  _buildCartCount() {
    return Container(
      alignment: Alignment.center,
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Observer(builder: (_) {
        List<ProductModel> cartList = _cartDataSource.customerCart;
        return Text(
          cartList.length.toString(),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        );
      }),
    );
  }

  @override
  void dispose() {
    setAllOrientations();
    super.dispose();
  }
}
