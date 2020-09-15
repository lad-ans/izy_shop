import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/configs/core_config.dart';
import '../../../../core/consts/img.dart';
import '../../../store/presentation/widgets/store_tile.dart';

class MarketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
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
            child: _buildContainerContent(context),
          ),
        ),
        _buildBackButton(),
      ],
    );
  }

  Padding _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 55.0, horizontal: 30.0),
      child: IconButton(
        icon: Icon(Ionicons.ios_arrow_back, color: Colors.white, size: 40),
        onPressed: () => Modular.to.pop(),
      ),
    );
  }

  Widget _buildContainerContent(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Image.asset(LOGO_NAMED_WHITE, width: 90, height: 90),
          Expanded(
            child: ListView(
              children: [
                StoreTile(
                    img: SPAR,
                    onTap: () => Modular.to.pushNamed('/store/shopping')),
                StoreTile(
                    img: GAME,
                    onTap: () => Modular.to.pushNamed('/store/shopping')),
                StoreTile(
                    img: WOOLWORTHS,
                    onTap: () => Modular.to.pushNamed('/store/shopping')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
