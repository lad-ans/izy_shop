import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color color;
  final String title;
  final Widget trailingWidget;
  final bool showElevation;
  final Color backgroundColor;
  final Color titleColor;
  const CustomAppBar({
    Key key,
    this.onPressed,
    this.iconData,
    this.color,
    this.title,
    this.trailingWidget,
    this.showElevation = true,
    this.backgroundColor,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildCustomLeading(
      {IconData iconData, Color color, VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(iconData, color: color, size: 30),
      onPressed: onPressed,
    );
  }

  Widget _buildCustomTitle(BuildContext context, String title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: titleColor ?? Theme.of(context).primaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildCustomTrailing(Widget widget) {
    return widget;
  }

  Container _buildBody(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        boxShadow: showElevation
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.3,
                  blurRadius: 0.3,
                  offset: Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: <Widget>[
            _buildCustomLeading(
                color: color, iconData: iconData, onPressed: onPressed),
            SizedBox(width: 20),
            Expanded(child: _buildCustomTitle(context, title)),
            _buildCustomTrailing(trailingWidget) ?? Text(''),
          ],
        ),
      ),
    );
  }
}
