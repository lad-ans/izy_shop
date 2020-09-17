import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        height: getHeight(context),
        width: getWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(APPLE_WALLPAPER),
          ),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: _buildColumn(context)),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 10.0),
        Image.asset(LOGO_NAMED_WHITE, width: 120, height: 120),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
                iconColor: Colors.white,
                icon: Zocial.facebook,
                text: 'Login With Facebook',
                onTap: () {}),
            SizedBox(width: 20.0),
            RoundedButton(
              iconColor: Colors.white,
              icon: Zocial.google,
              text: 'Login With Google',
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: 30.0),
        _buildOr(context),
        SizedBox(height: 15.0),
        CustomTextField(
          height: 55.0,
          fillColor: Colors.white,
          labelText: 'E-mail',
          filled: true,
        ),
        SizedBox(height: 10.0),
        CustomTextField(
          height: 55.0,
          fillColor: Colors.white,
          labelText: 'Password',
          filled: true,
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              iconColor: Colors.white,
              icon: AntDesign.edit,
              text: 'Register',
              onTap: () => Modular.to.pushNamed('/auth/signup'),
            ),
            RoundedButton(
              icon: FontAwesomeIcons.check,
              text: 'Confirm',
              isGreenColor: true,
              onTap: () => Modular.to.pushReplacementNamed('/home/city'),
            ),
          ],
        ),
        Expanded(child: SizedBox(height: 30)),
        CustomText(text: 'New to izyshop? Register for an account.')
      ],
    );
  }

  Row _buildOr(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
                width: getWidth(context), height: 1, color: Colors.white)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Login With Email And Password',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        Expanded(
            child: Container(
                width: getWidth(context), height: 1, color: Colors.white))
      ],
    );
  }
}
