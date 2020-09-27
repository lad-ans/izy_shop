import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/configs/core_config.dart';
import '../../core/domain/entities/route_entity.dart';
import '../../core/presentation/widgets/amount_checkout_row.dart';
import '../../core/presentation/widgets/custom_statusbar.dart';
import '../../core/presentation/widgets/rounded_button.dart';
import '../../core/presentation/widgets/shopping_appbar.dart';
import '../auth/presentation/widgets/custom_text.dart';
import '../product/data/models/product_model.dart';
import '../product/presentation/widgets/item_tile.dart';
import 'cart_controller.dart';
import 'presentation/stores/get_customer_cart_store.dart';

class CartPage extends StatefulWidget {
  final RouteEntity routeEntity;
  const CartPage({
    Key key,
    this.routeEntity,
  }) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
  final getCustomerCartStore = Modular.get<GetCustomerCartStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 170.0,
        child: _buidBottomNavBar(),
      ),
    );
  }

  Widget _buidBottomNavBar() {
    return Observer(builder: (_) {
      List<ProductModel> productList = getCustomerCartStore.cartList.data;
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
      var subTotal = 0;
      for (var item in productList) {
        subTotal += item.price;
      }
      return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AmountCheckoutRow(title: 'SubTotal', amount: subTotal.toString()),
            AmountCheckoutRow(title: 'Delivery', amount: '350,00'),
            AmountCheckoutRow(
                title: 'Total Amount', amount: (subTotal + 350).toString()),
            Divider(color: Colors.green[200]),
            RoundedButton(
              onTap: () => Modular.to.pushNamed('/checkout',
                  arguments: RouteEntity(
                      storeImg: widget.routeEntity.storeImg,
                      marketName: widget.routeEntity.marketName)),
              isGreenColor: true,
              icon: Icons.check,
              iconSize: 30.0,
              text: 'Confirm',
              btnWidth: 50.0,
              btnHeight: 50.0,
              width: 70.0,
              textColor: Colors.black87,
              textSize: 14.0,
            )
          ]);
    });
  }

  Widget _buildBody() {
    return Container(
      height: getHeight(context),
      child: Stack(
        children: [
          SizedBox(height: getStatusBar(context)),
          Padding(
            padding: EdgeInsets.only(top: 75),
            child: SingleChildScrollView(
              child: Observer(builder: (_) {
                List<ProductModel> productList =
                    getCustomerCartStore.cartList.data;
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: productList.map((productModel) {
                    return _buildBodyContent(
                      productModel.img,
                      productModel.name,
                      productModel.description ?? 'No description!',
                      productModel.price,
                      productModel,
                    );
                  }).toList(),
                );
              }),
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
            padding: EdgeInsets.only(top: getStatusBar(context)),
            child: ShoppingAppBar(
              routeEntity: widget.routeEntity,
              fullAppBar: false,
              isCartPage: true,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBodyContent(
    String product,
    String itemDesc,
    String itemDescDetail,
    num price,
    ProductModel productModel,
  ) {
    return Container(
      height: 70.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Expanded(
                child: ItemTile(
                    productModel: productModel,
                    itemWidth: 70,
                    isOnCart: true,
                    elevation: 0.0,
                    hPadd: 0.0,
                    productImg: product,
                    showItemPrice: false),
              ),
              Text('$price MT',
                  style: TextStyle(fontSize: 11.0, color: Colors.red[300]))
            ],
          ),
          _buildItemDesc(itemDesc, itemDescDetail),
          _buildItemInc(),
        ],
      ),
    );
  }

  Column _buildItemDesc(String itemDesc, String itemDescDetail) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: itemDesc,
          bold: true,
          fontSize: 12.0,
          width: 100.0,
          textColor: Colors.black,
        ),
        CustomText(
          text: itemDescDetail,
          fontSize: 12.0,
          width: 100.0,
          textColor: Colors.black,
        ),
      ],
    );
  }

  Container _buildItemInc() {
    return Container(
      alignment: Alignment.center,
      height: 30.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(2.0, 0.0),
              blurRadius: 3.0,
              color: Colors.black.withOpacity(0.36),
            ),
          ],
          color: Colors.yellow),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(child: Icon(Icons.remove, size: 15), onTap: () {}),
          SizedBox(width: 10.0),
          Text(
            ' 7 ',
            style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          SizedBox(width: 10.0),
          InkWell(child: Icon(Icons.add, size: 15), onTap: () {}),
        ],
      ),
    );
  }
}
