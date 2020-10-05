import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/consts/img.dart';
import '../../customer/domain/entities/logged_user.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      if (LoggedUser.instance.loggedUserUid == null) {
        Modular.to.pushReplacementNamed('/auth');
      } else {
        Modular.to.pushReplacementNamed('/home/city');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Image.asset(LOGO_NAMED),
        ),
      ),
    );
  }
}
