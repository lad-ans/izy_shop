import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../configs/core_config.dart';
import '../../consts/img.dart';

class ShoppingAppBar extends StatefulWidget {
  final bool showNavText;
  final bool isCartPage;
  const ShoppingAppBar({
    Key key,
    this.showNavText = true,
    this.isCartPage = false,
  }) : super(key: key);

  @override
  _ShoppingAppBarState createState() => _ShoppingAppBarState();
}

class _ShoppingAppBarState extends State<ShoppingAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: !widget.showNavText ? 50.0 : 65,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      width: getWidth(context),
      child: Row(
        children: [
          _buildRoundedButton(Icons.arrow_back, label: 'Back', onTap: () {
            Modular.to.pop();
          }),
          SizedBox(width: 2.0),
          Image.asset(LOGO, height: !widget.showNavText ? 45.0 : 55.0),
          SizedBox(width: 2.0),
          Visibility(
              visible: widget.showNavText,
              child:
                  Image.asset(SPAR, height: widget.showNavText ? 30.0 : 55.0)),
          SizedBox(width: 2.0),
          Visibility(
              visible: widget.showNavText, child: _buildNavigationText()),
          Expanded(child: SizedBox()),
          _buildRoundedButton(Icons.search, label: 'Search', onTap: () {}),
          _buildRoundedButton(AntDesign.filter, label: 'Filters', onTap: () {}),
          _buildRoundedButton(AntDesign.question, label: 'Help', onTap: () {}),
          _buildRoundedButton(AntDesign.user, label: 'Profile', onTap: () {}),
          _buildGold()
        ],
      ),
    );
  }

  Widget _buildNavigationText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Supermarkets / Departaments / ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Products',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildGold() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'gold'.toUpperCase(),
          style: TextStyle(
            color: Colors.amber,
            fontSize: !widget.showNavText ? 18 : 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            _buildStar(),
            _buildStar(),
            _buildStar(),
            _buildStar(),
            _buildStar(),
          ],
        )
      ],
    );
  }

  Icon _buildStar() {
    return Icon(
      Ionicons.ios_star,
      size: !widget.showNavText ? 10.0 : 14.0,
      color: Colors.amber,
    );
  }

  Widget _buildRoundedButtonLabel(String label) => Container(
        width: !widget.showNavText ? 30.0 : 45,
        child: Text(
          label ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: !widget.showNavText ? 8.0 : 12.0,
          ),
        ),
      );

  Widget _buildRoundedButton(IconData icon,
      {VoidCallback onTap, String label}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(45.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: [
            Container(
                height: !widget.showNavText ? 40.0 : 45.0,
                width: !widget.showNavText ? 40.0 : 45.0,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(
                        widget.showNavText ? 30.0 : 45.0)),
                child: Icon(icon,
                    size: !widget.showNavText ? 20 : 30.0,
                    color: Colors.white)),
            _buildRoundedButtonLabel(label),
          ],
        ),
      ),
    );
  }
}
