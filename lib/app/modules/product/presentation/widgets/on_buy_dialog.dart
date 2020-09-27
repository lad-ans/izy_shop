import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/custom_rich_text.dart';
import '../../data/models/product_model.dart';

class OnBuyDialog extends StatelessWidget {
  final bool isSelected;
  final ProductModel productModel;
  const OnBuyDialog({
    Key key,
    this.isSelected = false,
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildContentRow(),
            ),
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

  Row _buildContentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumnLeft(),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 30.0),
          child: _buildColumnRight(),
        ),
      ],
    );
  }

  Column _buildColumnRight() {
    return Column(
      children: [
        CustomRichText(
            labelOne: 'Price: ', labelTwo: '${productModel?.price} MT'),
        SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: productModel.img,
            height: 150,
          ),
        ),
        Divider(),
        Text(productModel.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Column _buildColumnLeft() {
    return Column(
      children: [
        Text('Select Size'),
        SizedBox(height: 4.0),
        Row(
          children: [
            _buildItemSize(imgItem: APPLES, size: 'small'),
            SizedBox(width: 10.0),
            _buildItemSize(imgItem: APPLES, size: 'large', isSelected: true),
          ],
        ),
        Divider(),
        Text('Select quantity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            _buildOnQtySelect(qty: '0.5kg'),
            _buildOnQtySelect(qty: '1kg', isSelected: true),
            _buildOnQtySelect(qty: '5kg'),
            _buildOnQtySelect(qty: '10kg'),
          ],
        )
      ],
    );
  }

  Widget _buildOnQtySelect({String qty, bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Text(qty),
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.green[200] : Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                width: 0.6,
                color: isSelected ? Colors.green[200] : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildItemSize(
      {String imgItem, String size, bool isSelected = false}) {
    return Column(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green[200] : Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              width: 0.6,
              color: isSelected ? Colors.green[200] : Colors.black,
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: productModel.img,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              )),
        ),
        Text(size, style: TextStyle(fontSize: 12))
      ],
    );
  }
}
