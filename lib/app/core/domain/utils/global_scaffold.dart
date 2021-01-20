import 'package:flutter/material.dart';

class GlobalScaffold {
  GlobalScaffold._internal();
  static final GlobalScaffold instance = GlobalScaffold._internal();

  factory GlobalScaffold() => instance;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(SnackBar snackBar) =>
      scaffoldKey.currentState.showSnackBar(snackBar);
}
