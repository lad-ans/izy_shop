import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/configs/core_config.dart';
import '../../../../core/consts/img.dart';
import '../../../auth/presentation/widgets/custom_textfield.dart';
import '../../../auth/presentation/widgets/rounded_button.dart';

class CitySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
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
          child: _buildColumn(context),
        ),
      ),
    );
  }

  final Text _selectACity = Text(
    'Please tap in a city to start browsing',
    style: TextStyle(color: Colors.white),
  );

  Column _buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(LOGO_NAMED_WHITE, width: 120, height: 120),
        Column(
          children: [
            _selectACity,
            SizedBox(height: 20.0),
            CustomTextField(
              height: 55.0,
              fillColor: Colors.white,
              labelText: 'City',
              filled: true,
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerRight,
          child: RoundedButton(
            icon: FontAwesomeIcons.check,
            text: 'Confirm',
            hasCustomColor: true,
            onTap: () => Modular.to.pushReplacementNamed('/home'),
          ),
        ),
      ],
    );
  }
}
