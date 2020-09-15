import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/configs/core_config.dart';
import '../../../../../core/consts/img.dart';
import '../../../../../core/presentation/widgets/custom_statusbar.dart';
import '../../../../../core/presentation/widgets/shopping_appbar.dart';
import '../../../../product/presentation/widgets/item_tile.dart';
import '../../../../product/presentation/widgets/product_list.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

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
            child: Column(
              children: [
                SizedBox(height: 75 + getStatusBar(context)),
                ProductList(listTitle: 'Categoria 1'),
                SizedBox(height: 10.0),
                ProductList(listTitle: 'Categoria 2'),
                SizedBox(height: 10.0),
                ProductList(listTitle: 'Categoria 3'),
                SizedBox(height: 10.0),
                ProductList(listTitle: 'Categoria 4'),
                SizedBox(height: 75.0),
              ],
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
              padding: EdgeInsets.only(top: getStatusBar(context)),
              child: ShoppingAppBar()),
          Positioned(bottom: 0.0, child: _buildBottomNavBar())
        ],
      ),
    );
  }

  Container _buildBottomNavBar() {
    return Container(
      // color: Colors.black12,
      width: getWidth(context),
      height: 60.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildListItem()),
          _buildCartTile(),
        ],
      ),
    );
  }

  ListView _buildListItem() => ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: PAPAYA,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: RICE,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: YOGURT,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: BEANS,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: MEAT,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: POTATOES,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: BEANS,
              showItemPrice: false),
          ItemTile(
              isOnCart: true,
              height: 30,
              color: Theme.of(context).cardColor,
              product: APPLES,
              showItemPrice: false),
        ],
      );

  Widget _buildCartTile() {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/cart'),
      child: Container(
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
        ),
        height: 60.0,
        width: 150.0,
        child: _buildCart(),
      ),
    );
  }

  Container _buildCart() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'add'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
      child: Text(
        '5',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
