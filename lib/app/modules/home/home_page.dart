import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/configs/core_config.dart';
import '../../core/domain/consts/img.dart';
import '../store/presentation/widgets/store_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
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
                  img: SUPERMARKET,
                  label: 'Supermarket',
                  onTap: () => Modular.to.pushNamed('/home/market'),
                ),
                StoreTile(
                  img: FARMER_PRODUCT,
                  label: 'Farmers Market',
                  onTap: () => Modular.to.pushNamed('/home/market'),
                ),
                StoreTile(
                  img: RESTAURANT,
                  label: 'Restaurants',
                  onTap: () => Modular.to.pushNamed('/home/market'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
