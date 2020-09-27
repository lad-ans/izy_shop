import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/entities/route_entity.dart';
import '../../../../core/presentation/widgets/custom_statusbar.dart';
import '../../../../core/presentation/widgets/shopping_appbar.dart';
import '../../../cart/presentation/stores/get_customer_cart_store.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/presentation/stores/add_to_cart_store.dart';
import '../../../product/presentation/stores/get_product_by_category_store.dart';
import '../../../product/presentation/widgets/item_tile.dart';
import '../../../product/presentation/widgets/product_list.dart';

class ShoppingPage extends StatefulWidget {
  final RouteEntity routeEntity;
  const ShoppingPage(
    this.routeEntity,
  );
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  void initState() {
    setLandscapeOrientation();
    getCustomerCartStore.execute('uuid');
    super.initState();
  }

  final GetProductByCategoryStore getProductByCategoryStore =
      Modular.get<GetProductByCategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: getHeight(context),
      child: Stack(
        children: [
          SizedBox(height: getStatusBar(context)),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 75 + getStatusBar(context)),
              child: Column(
                  children: widget.routeEntity.productCategories
                          .map((productCategory) {
                        return ProductList(
                          onAddToCart: (data) {
                            this.product = data;
                          },
                          routeEntity: widget.routeEntity,
                          listTitle: productCategory,
                        );
                      }).toList() ??
                      <Widget>[Center(child: Text('No Items!'))]),
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
              padding: EdgeInsets.only(top: getStatusBar(context)),
              child: ShoppingAppBar(
                routeEntity: widget.routeEntity,
              )),
          Positioned(bottom: 0.0, child: _buildBottomNavBar(context))
        ],
      ),
    );
  }

  Container _buildBottomNavBar(BuildContext context) {
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

  final getCustomerCartStore = Modular.get<GetCustomerCartStore>();
  Widget _buildListItem() => Observer(
        builder: (_) {
          List<ProductModel> cartList = getCustomerCartStore.cartList.data;
          if (getCustomerCartStore.cartList.hasError) {
            return Center(
              child: Text('Error Occured'),
            );
          }
          if (getCustomerCartStore.cartList.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              ProductModel product = cartList[index];
              return ItemTile(
                itemWidth: 60.0,
                isOnBasket: true,
                color: Theme.of(context).cardColor,
                productModel: product,
                showItemPrice: false,
              );
            },
          );
        },
      );

  ProductModel product;
  Widget _buildCartTile(BuildContext context) {
    return DragTarget(
      builder: (context, List<ProductModel> candidate, rejected) {
        return InkWell(
          onTap: () async {
            setAllOrientations();
            await Modular.to.pushNamed('/cart',
                arguments: RouteEntity(storeImg: widget.routeEntity.storeImg));
            setLandscapeOrientation();
          },
          child: Container(
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)),
            ),
            height: 60.0,
            width: 130.0,
            child: _buildCart(),
          ),
        );
      },
      onWillAccept: (value) {
        return true;
      },
      onAccept: (value) async {
        await Modular.get<AddToCartStore>().execute(product);
      },
    );
  }

  Container _buildCart() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('add'.toUpperCase(), style: TextStyle(color: Colors.white)),
          Stack(
            overflow: Overflow.visible,
            children: [
              Icon(
                Icons.add_shopping_cart,
                size: 40,
                color: Colors.white,
              ),
              Positioned(
                top: -8.0,
                right: -5.0,
                child: _buildCartCount(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartCount() {
    return Container(
      alignment: Alignment.center,
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
          color: Colors.redAccent, borderRadius: BorderRadius.circular(10.0)),
      child: Observer(builder: (_) {
        List<ProductModel> cartList = getCustomerCartStore.cartList.data;
        if (getCustomerCartStore.cartList.hasError) {
          return Center(
            child: Text('Error Occured'),
          );
        }
        if (getCustomerCartStore.cartList.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
