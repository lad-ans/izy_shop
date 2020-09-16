import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/configs/core_config.dart';
import '../../../../core/consts/img.dart';
import '../../../../core/presentation/widgets/custom_rich_text.dart';

class OnBuyDialog extends StatelessWidget {
  final bool isSelected;
  const OnBuyDialog({
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
            borderRadius: BorderRadius.circular(8.0),
          ),
          children: [
            _buildContentRow(),
          ],
        ),
        Positioned(
          top: getHeight(context) / 9.5,
          left: getWidth(context) / 6,
          child: _buildDialogButton(
            height: 50.0,
            width: 50.0,
            color: Colors.black38,
            icon: Icons.close,
          ),
        ),
        Positioned(
          bottom: getHeight(context) / 12,
          right: getWidth(context) / 6,
          child: GestureDetector(
            onTap: () => Modular.to.pop(),
            child: _buildDialogButton(
              height: 70.0,
              width: 70.0,
              color: Colors.green,
              icon: Icons.check,
            ),
          ),
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
        _buildColumnRight(),
      ],
    );
  }

  Column _buildColumnRight() {
    return Column(
      children: [
        CustomRichText(labelOne: 'Price: ', labelTwo: '160,00 MT / kg'),
        CustomRichText(labelOne: 'Amount: ', labelTwo: '845,00 MT'),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            APPLES,
            width: 200,
          ),
        ),
        Divider(),
        Text('Red Apples',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('(Imported)', style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Column _buildColumnLeft() {
    return Column(
      children: [
        Text('Select Size'),
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
              child: Image.asset(
                imgItem,
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
