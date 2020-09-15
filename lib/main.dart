import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:izy_shop/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );
  runApp(ModularApp(module: AppModule()));
}
