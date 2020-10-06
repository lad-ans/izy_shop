import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:izy_shop/app/app_controller.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';

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

  final AppController _controller = Modular.get<AppController>();
  Column _buildColumn() {
    return Column(
      children: [
        Image.asset(LOGO_NAMED_WHITE),
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedButton(
              iconColor: Colors.white,
              icon: Ionicons.ios_log_in,
              text: 'Login',
              onTap: () async {
                _controller.select(0);
                await Modular.to.pushNamed('/auth/login');
                _controller.select(100);
              },
              index: 0,
            ),
            RoundedButton(
              iconColor: Colors.white,
              icon: AntDesign.edit,
              text: 'Register',
              onTap: () async {
                _controller.select(1);
                await Modular.to.pushNamed('/auth/signup');
                _controller.select(200);
              },
              index: 1,
            ),
            RoundedButton(
              iconColor: Colors.white,
              icon: FontAwesomeIcons.users,
              text: 'Guest',
              onTap: () async {
                _controller.select(2);
                await Modular.to.pushReplacementNamed('/home/city');
                _controller.select(300);
              },
              index: 2,
            ),
          ],
        ),
      ],
    );
  }
}
