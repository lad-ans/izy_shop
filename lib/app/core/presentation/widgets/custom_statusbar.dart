import 'package:flutter/material.dart';

import '../../domain/configs/core_config.dart';


class CustomStatusBar extends StatelessWidget {
  final Color color;
  const CustomStatusBar({
    Key key,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getStatusBar(context),
      color: color ?? Theme.of(context).primaryColor,
    );
  }
}
