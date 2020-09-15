import 'package:flutter/widgets.dart';

/// get screen width
double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

/// get screen height
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// get statusbar
double getStatusBar(BuildContext context) => MediaQuery.of(context).padding.top;
