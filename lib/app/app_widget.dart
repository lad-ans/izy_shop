import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/core/domain/utils/global_scaffold.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      builder: (context, child) {
        return Scaffold(
          key: GlobalScaffold.instance.scaffoldKey,
          body: child,
        );
      },
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
