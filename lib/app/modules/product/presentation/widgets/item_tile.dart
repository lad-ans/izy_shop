import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/consts/img.dart';
import 'description_dialog.dart';
import 'on_buy_dialog.dart';

class ItemTile extends StatelessWidget {
  final Color color;
  final double elevation;
  final double hPadd;
  final bool showItemPrice;
  final String product;
  final double height;
  final bool isOnCart;
  const ItemTile({
    Key key,
    this.color,
    this.elevation,
    this.hPadd,
    this.showItemPrice = true,
    this.product,
    this.height,
    this.isOnCart = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      feedback: _buildDraggableFeedback(),
      child: GestureDetector(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: !isOnCart
                ? (context) => OnBuyDialog()
                : (context) => DescriptionDialog(),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: hPadd ?? 4.0),
          child: Stack(
            children: [
              _buildImgTile(),
              Positioned(
                top: 5.0,
                right: 5.0,
                child: _buildItemPrice(),
              ),
              Positioned(
                bottom: 5.0,
                right: 5.0,
                child: _buildAddToCartButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDraggableFeedback() {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(product, fit: BoxFit.contain)),
    );
  }

  Material _buildImgTile() {
    return Material(
      color: color ?? Colors.transparent,
      elevation: elevation ?? 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(product ?? POTATOES)),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Visibility(
      visible: showItemPrice,
      child: InkWell(
        child: Icon(
          Ionicons.ios_add_circle,
          color: Colors.green[200],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildItemPrice() {
    return Visibility(
      visible: showItemPrice,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '123,45 MT (unit)',
              style: TextStyle(
                color: Colors.red[200],
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
