import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/domain/entities/route_entity.dart';
import '../../../../core/domain/utils/number_formatter.dart';
import '../../../../core/presentation/widgets/amount_checkout_row.dart';
import '../../../../core/presentation/widgets/custom_statusbar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/shopping_appbar.dart';
import '../../../auth/presentation/widgets/custom_text.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/presentation/widgets/item_tile.dart';
import '../../data/datasources/cart_data_source.dart';

class CartPage extends StatefulWidget {
  final RouteEntity routeEntity;
  const CartPage({
    Key key,
    this.routeEntity,
  }) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartDataSource = Modular.get<CartDataSource>();

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
      List<ProductModel> productList = _cartDataSource.customerCart;
      num subTotal = 0;

      for (ProductModel item in productList) {
        if (item.hasSize || item.hasVol || item.hasWeight) {
          var key;
          item.selectedItem.keys.map((k) => key = k).toList();
          subTotal += item.selectedItem[key] * item.qty;
        } else {
          subTotal += item.price * item.qty;
        }
      }
      num deliveryPrice;
      if (subTotal < 3999) {
        deliveryPrice = 350;
      } else {
        deliveryPrice = 0;
      }

      num total = subTotal + deliveryPrice;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AmountCheckoutRow(
              title: 'SubTotal',
              amount: NumberFormatter.instance.numToString(subTotal)),
          AmountCheckoutRow(
            title: 'Delivery',
            amount:
                NumberFormatter.instance.numToString(deliveryPrice).toString(),
          ),
          AmountCheckoutRow(
              title: 'Total Amount',
              amount: NumberFormatter.instance.numToString(total)),
          Divider(color: Colors.green[200]),
          RoundedButton(
            isNull: LoggedUser.instance.loggedUserUid == null ||
                productList.length == 0,
            onTap: productList.length == 0
                ? null
                : () => Modular.to.pushNamed(
                      '/checkout',
                      arguments: RouteEntity(
                          storeId: widget.routeEntity.storeId,
                          cartList: productList,
                          totalAmount: total,
                          deliveryPrice: deliveryPrice,
                          subtotal: subTotal,
                          storeImg: widget.routeEntity.storeImg,
                          storeCategory: widget.routeEntity.storeCategory),
                    ),
            isGreenColor: (LoggedUser.instance.loggedUserUid != null) &&
                (productList.length != 0),
            icon: Icons.check,
            iconSize: 30.0,
            text: 'Confirm',
            btnWidth: 50.0,
            btnHeight: 50.0,
            width: 70.0,
            textColor: Colors.black87,
            textSize: 14.0,
          )
        ],
      );
    });
  }

  _buildBody() {
    return Observer(builder: (_) {
      List<ProductModel> productList = _cartDataSource.customerCart;
      return Container(
        height: getHeight(context),
        child: Stack(
          children: [
            SizedBox(height: getStatusBar(context)),
            Padding(
              padding: EdgeInsets.only(top: 75),
              child: SingleChildScrollView(
                child: productList.length == 0
                    ? _buildEmptyCart()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildHeader(),
                          Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: productList.map<Widget>((productModel) {
                              return _buildBodyContent(
                                productModel.img,
                                productModel.name,
                                productModel.description ?? 'No description!',
                                productModel.price,
                                productModel,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
              ),
            ),
            CustomStatusBar(color: Colors.white),
            Padding(
              padding: EdgeInsets.only(top: getStatusBar(context)),
              child: ShoppingAppBar(
                onNavigate: true,
                routeEntity: widget.routeEntity,
                fullAppBar: false,
              ),
            ),
          ],
        ),
      );
    });
  }

  Container _buildEmptyCart() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(EMPTY_CART, width: 200),
          SizedBox(height: 40.0),
          FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () async {
              await Modular.to.pushNamed('/home');
              setAllOrientations();
            },
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.red[300],
              size: 50.0,
            ),
            label: Text(
              'Start Shopping',
              style: TextStyle(
                color: Colors.red[300],
                fontSize: 30.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle get kStyle => TextStyle(
      color: Colors.red[300],
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins');

  Container _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              width: 80,
              child: Text('Product', style: kStyle)),
          Container(
              alignment: Alignment.center,
              width: 130,
              child: Text('Description', style: kStyle)),
          Container(
              alignment: Alignment.center,
              width: 130,
              child: Text('Quantity', style: kStyle)),
        ],
      ),
    );
  }

  _buildBodyContent(
    String product,
    String itemDesc,
    String itemDescDetail,
    num price,
    ProductModel productModel,
  ) {
    String key;
    if (productModel.hasSize || productModel.hasVol || productModel.hasWeight) {
      productModel.selectedItem.keys.map((k) => key = k).toList();
    }
    return Container(
      height: 70.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            child: Column(
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
                Text(
                  productModel.hasSize ||
                          productModel.hasVol ||
                          productModel.hasWeight
                      ? '${NumberFormatter.instance.numToString(productModel.selectedItem[key] * productModel.qty)} MT'
                      : '${NumberFormatter.instance.numToString(price * productModel.qty)} MT',
                  style: TextStyle(fontSize: 11.0, color: Colors.red[300]),
                ),
              ],
            ),
          ),
          Container(
              width: 130, child: _buildItemDesc(itemDesc, itemDescDetail)),
          Container(width: 130, child: _buildItemInc(productModel)),
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

  Container _buildItemInc(ProductModel productModel) {
    return Container(
      alignment: Alignment.center,
      height: 40.0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      decoration: BoxDecoration(
          color: Colors.yellow[200],
          border: Border.all(color: Colors.yellow[200], width: 1.0),
          borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(40.0),
            child: Material(
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                elevation: 5.0,
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                        Icon(Icons.remove, size: 20, color: Colors.black87))),
            onTap: () {
              if (productModel.qty > 1) {
                setState(() {
                  productModel.qty--;
                });
              }
            },
          ),
          SizedBox(width: 15.0),
          Text(
            productModel.qty.toString(),
            style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          SizedBox(width: 15.0),
          InkWell(
            borderRadius: BorderRadius.circular(40.0),
            child: Material(
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(Icons.add, size: 20, color: Colors.black87),
              ),
            ),
            onTap: () {
              if (productModel.qty >= 1) {
                setState(() {
                  productModel.qty++;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
