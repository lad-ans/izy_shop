import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/configs/core_config.dart';
import '../../domain/consts/img.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, getStatusBar(context), 20.0, 20.0),
      height: getHeight(context),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(APPLE_WALLPAPER))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: getStatusBar(context) + 60.0 + 60.0),
              child: _buildListView(),
            ),
            _buildCloseButton(),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: _buildTextField(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(
      {String product, String title, String price, String vendor}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(product, width: 100.0)),
        title: Text(
          title,
          // overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white70),
        ),
        subtitle: Text(
          '$price MT',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(vendor, width: 100.0)),
      ),
    );
  }

  Container _buildListView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView(
        children: [
          _buildItemTile(
            product: MEAT,
            title: 'Carnes e Peixes',
            price: '234,00',
            vendor: WOOLWORTHS,
          ),
          _buildItemTile(
            product: BEANS,
            title: 'Feijão Manteiga',
            price: '57,00',
            vendor: GAME,
          ),
          _buildItemTile(
            product: YOGURT,
            title: 'Yogurt Natural',
            price: '154,00',
            vendor: SPAR,
          ),
          _buildItemTile(
            product: MEAT,
            title: 'Carnes e Peixes',
            price: '234,00',
            vendor: WOOLWORTHS,
          ),
          _buildItemTile(
            product: BEANS,
            title: 'Feijão Manteiga',
            price: '57,00',
            vendor: GAME,
          ),
          _buildItemTile(
            product: YOGURT,
            title: 'Yogurt Natural',
            price: '154,00',
            vendor: SPAR,
          ),_buildItemTile(
            product: MEAT,
            title: 'Carnes e Peixes',
            price: '234,00',
            vendor: WOOLWORTHS,
          ),
          _buildItemTile(
            product: BEANS,
            title: 'Feijão Manteiga',
            price: '57,00',
            vendor: GAME,
          ),
          _buildItemTile(
            product: YOGURT,
            title: 'Yogurt Natural',
            price: '154,00',
            vendor: SPAR,
          ),
        ],
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      style: TextStyle(color: Colors.black54, fontSize: 18.0),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.black54, fontSize: 18.0),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            AntDesign.search1,
            color: Colors.black54,
            size: 35.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white60, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white60, width: 0.7),
        ),
      ),
    );
  }

  Positioned _buildCloseButton() {
    return Positioned(
      right: 0.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: () => Modular.to.pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(40.0)),
            child: Icon(
              Icons.close,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
