import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/models/product_model.dart';

class CartProductDialog extends StatelessWidget {
  final bool isSelected;
  final ProductModel productModel;
  const CartProductDialog({
    Key key,
    this.isSelected = false,
    this.productModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white.withOpacity(0.85),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            _buildContentRow(context),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _buildDialogButton(
                  height: 30.0,
                  width: 30.0,
                  color: Colors.black38,
                  icon: Icons.close,
                ),
              ),
            ),
          ],
        ),
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
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildContentLeft(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: productModel.img,
                  height: 70.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentLeft() {
    return Container(
      child: Text(
        productModel.description ?? 'Some description!',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
