import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/widgets/custom_rich_text.dart';
import '../../data/models/product_model.dart';

class DescriptionDialog extends StatelessWidget {
  final bool isSelected;
  final bool isFromNet;
  final ProductModel productModel;
  const DescriptionDialog({
    Key key,
    this.isSelected = false,
    this.isFromNet = false,
    this.productModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white.withOpacity(0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
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
                  height: 40.0,
                  width: 40.0,
                  color: Colors.black38,
                  icon: Icons.close,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: GestureDetector(
                onTap: () => Modular.to.pop(),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildDialogButton(
                    height: 50.0,
                    width: 50.0,
                    color: Colors.green,
                    icon: Icons.check,
                  ),
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
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildColumnLeft(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 40.0),
            child: _buildColumnRight(),
          ),
        ],
      ),
    );
  }

  Column _buildColumnRight() {
    return Column(
      children: [
        CustomRichText(
            labelOne: 'Price: ', labelTwo: '${productModel.price} MT'),
        SizedBox(height: 8.0),
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: productModel.img,
              height: 150,
            )),
        Divider(),
        Text(productModel.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Column _buildColumnLeft() {
    return Column(
      children: [
        Text(
          'About the product',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Container(
          child: Text(
            productModel.description ?? 'No description!',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
