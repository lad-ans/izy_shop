import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/configs/core_config.dart';
import '../../core/consts/img.dart';
import '../../core/presentation/widgets/custom_rich_text.dart';
import '../../core/presentation/widgets/custom_statusbar.dart';
import '../../core/presentation/widgets/shopping_appbar.dart';
import '../auth/presentation/widgets/custom_text.dart';
import '../auth/presentation/widgets/rounded_button.dart';
import '../product/presentation/widgets/item_tile.dart';
import 'cart_controller.dart';

class CartPage extends StatefulWidget {
  final String title;
  const CartPage({Key key, this.title = "Cart"}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: getHeight(context) / 4.0,
        child: _buidBottomNavBar(),
      ),
    );
  }

  Column _buidBottomNavBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(color: Colors.green[200]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomRichText(labelOne: 'SubTotal: ', labelTwo: ' 23.000,98 MT'),
            CustomRichText(labelOne: 'Delivery: ', labelTwo: ' 345,00 MT'),
            CustomRichText(
                labelOne: 'Total Amount: ', labelTwo: ' 23.345,98 MT'),
          ],
        ),
        SizedBox(height: 10.0),
        RoundedButton(
          hasCustomColor: true,
          icon: Icons.check,
          text: 'Confirm',
          btnWidth: 70.0,
          btnHeight: 70.0,
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
              children: [
                SizedBox(height: 75 + getStatusBar(context)),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
                _buildBodyContent(),
              ],
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
            padding: EdgeInsets.only(top: getStatusBar(context)),
            child: ShoppingAppBar(showNavText: false),
          ),
        ],
      ),
    );
  }

  Container _buildBodyContent() {
    return Container(
      height: 70.0,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ItemTile(
              elevation: 0.0,
              hPadd: 0.0,
              product: POTATOES,
              showItemPrice: false),
          Expanded(child: _buildItemDesc()),
          _buildItemInc(),
          SizedBox(width: 10.0),
          Text('12.000,00 MT', style: TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }

  Column _buildItemDesc() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Red Apple (imported)',
          fontSize: 12.0,
          textColor: Colors.black,
        ),
        CustomText(
          text: '(1kg)',
          fontSize: 12.0,
          textColor: Colors.black87,
        ),
      ],
    );
  }

  Container _buildItemInc() {
    return Container(
      alignment: Alignment.center,
      height: 40.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Colors.yellow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(child: Icon(Icons.remove, size: 25), onTap: () {}),
          SizedBox(width: 10.0),
          Text('7', style: TextStyle(color: Colors.black, fontSize: 14)),
          SizedBox(width: 10.0),
          InkWell(child: Icon(Icons.add, size: 25), onTap: () {}),
        ],
      ),
    );
  }
}
