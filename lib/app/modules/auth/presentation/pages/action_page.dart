import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/configs/core_config.dart';
import '../../../../core/consts/img.dart';
import '../widgets/rounded_button.dart';

class ActionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Container _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      height: getHeight(context),
      width: getWidth(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(APPLE_WALLPAPER),
        ),
      ),
      child: _buildColumn(),
    );
  }

  Column _buildColumn() {
    return Column(
      children: [
        Image.asset(LOGO_NAMED_WHITE),
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedButton(
                icon: Ionicons.ios_log_in,
                text: 'Login',
                isSelected: true,
                onTap: () => Modular.to.pushNamed('/auth/login')),
            RoundedButton(
                icon: AntDesign.edit,
                text: 'Register',
                onTap: () => Modular.to.pushNamed('/auth/signup')),
            RoundedButton(
              icon: FontAwesomeIcons.users,
              text: 'Guest',
              onTap: () => Modular.to.pushReplacementNamed('/home/city'),
            ),
          ],
        ),
      ],
    );
  }
}
