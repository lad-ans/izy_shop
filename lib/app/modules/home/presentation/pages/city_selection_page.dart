import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../widgets/autocomplete_textfield.dart';

class CitySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(APPLE_WALLPAPER),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: SingleChildScrollView(
          child: _buildColumn(context),
        ),
      ),
    );
  }

  final Text _selectACity = Text(
    'Please tap in a city to start browsing',
    style: TextStyle(color: Colors.white),
  );

  Widget _buildColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
      height: getHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(LOGO_NAMED_WHITE, width: 120, height: 120),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectACity,
                SizedBox(height: 20.0),
                AutocompleteTextfield(
                  height: 55.0,
                  fillColor: Colors.white,
                  labelText: 'City',
                  filled: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              icon: FontAwesomeIcons.check,
              text: 'Confirm',
              isGreenColor: true,
              onTap: () => Modular.to.pushReplacementNamed('/home'),
            ),
          ),
        ],
      ),
    );
  }
}
