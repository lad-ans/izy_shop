import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/core/consts/img.dart';

import '../../../../core/configs/core_config.dart';

class CartProductDialog extends StatelessWidget {
  final bool isSelected;
  const CartProductDialog({
    Key key,
    this.isSelected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        SimpleDialog(
            backgroundColor: Colors.white.withOpacity(0.85),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text(
              'About the product',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
            children: [_buildContentRow(context)]),
        Positioned(
            top: getHeight(context) / 3.3,
            right: getWidth(context) / 20.5,
            child: _buildDialogButton(
                height: 50.0,
                width: 50.0,
                color: Colors.black38,
                icon: Icons.close))
      ],
    );
  }

  GestureDetector _buildDialogButton({
    double height,
    double width,
    Color color,
    IconData icon,
  }) {
    return GestureDetector(
      onTap: () => Modular.to.pop(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50.0)),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
              width: (getWidth(context) * 0.7) * 0.7,
              child: _buildContentLeft()),
          Container(
              width: (getWidth(context) * 0.7) * 0.3,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(80.0)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: Image.asset(POTATOES))),
        ],
      ),
    );
  }

  Widget _buildContentLeft() {
    return Container(
      child: Text(
        'Product description. Product description. Product description. Product description. Product description. ',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
