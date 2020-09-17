import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/custom_rich_text.dart';

class DescriptionDialog extends StatelessWidget {
  final bool isSelected;
  const DescriptionDialog({
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
            _buildContentRow(context),
          ],
        ),
        Positioned(
          top: getHeight(context) / 15,
          right: getWidth(context) / 6.15,
          child: _buildDialogButton(
            height: 50.0,
            width: 50.0,
            color: Colors.black38,
            icon: Icons.close,
          ),
        ),
        Positioned(
          bottom: getHeight(context) / 15,
          right: getWidth(context) / 6.15,
          child: GestureDetector(
            onTap: () => Modular.to.pop(),
            child: _buildDialogButton(
              height: 50.0,
              width: 50.0,
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

  Widget _buildContentRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: getWidth(context) * 0.6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              width: (getWidth(context) * 0.6) / 2,
              child: _buildColumnLeft(),
            ),
          ),
          _buildColumnRight(),
        ],
      ),
    );
  }

  Column _buildColumnRight() {
    return Column(
      children: [
        CustomRichText(labelOne: 'Price: ', labelTwo: '160,00 MT / kg'),
        SizedBox(height: 20.0),
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
        Text(
          'About the product',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: Text(
            'Product description. Product description. Product description. Product description. Product description. ',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
