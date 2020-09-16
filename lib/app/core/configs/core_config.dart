import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// get screen width
double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

/// get screen height
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// get statusbar
double getStatusBar(BuildContext context) => MediaQuery.of(context).padding.top;

/// set orientatio
Future<void> setAllOrientations() async {
  return await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

Future<void> setLandscapeOrientation() async {
  return await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

Future<void> setPortraitOrientations() async {
  return await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
