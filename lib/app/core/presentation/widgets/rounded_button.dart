import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_controller.dart';
import '../../../modules/auth/presentation/widgets/custom_text.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String text;
  bool isSelected;
  final int index;
  final bool isGreenColor;
  final VoidCallback onTap;
  final double width;
  final double btnWidth;
  final double btnHeight;
  final double textSize;
  final Color textColor;
  final double iconSize;
  final Color color, borderColor, iconColor;
  final String paymentMethod;
  final bool isCustomized;
  final bool isNull;
  RoundedButton({
    Key key,
    this.icon,
    this.text = '',
    this.isSelected = false,
    this.index,
    this.isGreenColor = false,
    this.onTap,
    this.width,
    this.btnWidth,
    this.btnHeight,
    this.textSize,
    this.textColor,
    this.iconSize,
    this.iconColor,
    this.borderColor,
    this.color,
    this.paymentMethod,
    this.isCustomized = false,
    this.isNull = false,
  }) : super(key: key);

  final AppController _controller = Modular.get<AppController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(80),
          onTap: isNull
              ? null
              : () {
                  onTap();
                },
          child: Observer(builder: (_) {
            isSelected = _controller.selectedIndex == index;
            return Container(
              width: btnWidth ?? 90,
              height: btnHeight ?? 90,
              decoration: BoxDecoration(
                border: Border.all(
                    color: (isSelected && isCustomized)
                        ? Colors.red[300]
                        : isSelected
                            ? Colors.black
                            : isGreenColor
                                ? Colors.green
                                : borderColor ?? Colors.white,
                    width: 0.7),
                borderRadius: BorderRadius.circular(80),
                color: isSelected
                    ? Colors.white
                    : isGreenColor ? Colors.green : color ?? Colors.black45,
              ),
              child: Icon(icon,
                  color: (isCustomized && isSelected)
                      ? Colors.red[300]
                      : isSelected
                          ? Colors.black
                          : isGreenColor
                              ? Colors.white
                              : iconColor ?? Colors.black,
                  size: iconSize ?? 50),
            );
          }),
        ),
        SizedBox(height: 5.0),
        CustomText(
            text: text, width: 90, fontSize: textSize, textColor: textColor),
      ],
    );
  }
}
