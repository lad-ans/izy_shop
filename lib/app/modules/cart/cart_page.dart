import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/configs/core_config.dart';
import '../../core/consts/img.dart';
import '../../core/presentation/widgets/amount_checkout_row.dart';
import '../../core/presentation/widgets/custom_statusbar.dart';
import '../../core/presentation/widgets/shopping_appbar.dart';
import '../auth/presentation/widgets/custom_text.dart';
import '../../core/presentation/widgets/rounded_button.dart';
import '../product/presentation/widgets/item_tile.dart';
import 'cart_controller.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
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

  Column _buidBottomNavBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AmountCheckoutRow(title: 'SubTotal', amount: '23.000,00'),
        AmountCheckoutRow(title: 'Delivery', amount: '350,00'),
        AmountCheckoutRow(title: 'Total Amount', amount: '23.350,00'),
        Divider(color: Colors.green[200]),
        RoundedButton(
          onTap: () => Modular.to.pushNamed('/checkout'),
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
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      height: getHeight(context),
      child: Stack(
        children: [
          SizedBox(height: getStatusBar(context)),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 75 + getStatusBar(context)),
                _buildBodyContent(POTATOES, 'National potatoes', '(fresh)'),
                _buildBodyContent(RICE, 'Basmati rice', ''),
                _buildBodyContent(PAPAYA, 'Papaya', '(from epoc)'),
                _buildBodyContent(APPLES, 'Red Apples', '(unit)'),
                _buildBodyContent(MEAT, 'Meat', ''),
                _buildBodyContent(YOGURT, 'Nutriday Yogurt', ''),
                _buildBodyContent(BEANS, 'Beans', ''),
              ],
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
            padding: EdgeInsets.only(top: getStatusBar(context)),
            child: ShoppingAppBar(fullAppBar: false, isCartPage: true),
          ),
        ],
      ),
    );
  }

  Container _buildBodyContent(
      String product, String itemDesc, String itemDescDetail) {
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
                    itemWidth: 60,
                    isOnCart: true,
                    elevation: 0.0,
                    hPadd: 0.0,
                    product: product,
                    showItemPrice: false),
              ),
              Text('(12.000,00 MT)',
                  style: TextStyle(fontSize: 10.0, color: Colors.red[300]))
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
          Text(' 7 ',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          SizedBox(width: 10.0),
          InkWell(child: Icon(Icons.add, size: 15), onTap: () {}),
        ],
      ),
    );
  }
}
