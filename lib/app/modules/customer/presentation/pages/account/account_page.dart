import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/domain/configs/core_config.dart';
import '../../../../../core/domain/consts/img.dart';
import '../../../../../core/presentation/widgets/custom_appbar.dart';
import '../../../customer_controller.dart';

class AccountPage extends StatefulWidget {
  final String title;
  AccountPage({
    Key key,
    this.title = "Customer",
  }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends ModularState<AccountPage, CustomerController> {
  TextEditingController _nameController =
      TextEditingController(text: 'Carlos Pedro Chirinza');
  TextEditingController _emailController =
      TextEditingController(text: 'kaka@email.com');
  TextEditingController _passwordController =
      TextEditingController(text: 'kaka12345');
  TextEditingController _phoneController =
      TextEditingController(text: '841234567');

  Widget _buildTrailingWidget() {
    return Container(
      // height: 60.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white70,
        onPressed: () {},
        child: Text(
          'Guardar',
          style: TextStyle(
            color: Colors.red[400],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String title,
    IconData suffixIcon,
    TextEditingController textController, {
    bool isPassword = false,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        style: TextStyle(
            fontFamily: 'SofiaPro',
            color: Colors.red[500],
            fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
              fontFamily: 'Poppins', color: Colors.red[300], fontSize: 12),
          suffixIcon: Icon(suffixIcon),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[200]),
              borderRadius: BorderRadius.circular(30.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[200]),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red[200]),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  _buildAvatarTile(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.red[300],
        borderRadius: BorderRadius.circular(75.0),
        border: Border.all(color: Colors.red[200], width: 2),
        image: DecorationImage(
          image: AssetImage(CUSTOMER),
          fit: BoxFit.cover,
        ),
      ),
      child: Visibility(
        visible: false,
        child: Center(
          child: Text(
            'c'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'SofiaPro',
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: getHeight(context),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(APPLE_WALLPAPER))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
                  child: _buildStack(context)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, getStatusBar(context), 20, 0),
                child: CustomAppBar(
                  backgroundColor: Colors.transparent,
                  showElevation: false,
                  iconData: Ionicons.ios_arrow_round_back,
                  color: Colors.white,
                  onPressed: () => Modular.to.pop(),
                  title: ''.toUpperCase(),
                  trailingWidget: _buildTrailingWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildStack(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return _buildCard();
          },
        ),
        Positioned(
          top: -70,
          left: getDeviceOrientation(context) == Orientation.portrait
              ? getHeight(context) / 5.8
              : getWidth(context) / 2.6,
          child: _buildAvatarTile(context),
        ),
      ],
    );
  }

  Card _buildCard() {
    return Card(

      color: Colors.white70,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            _buildInputField('Nome', AntDesign.user, _nameController),
            _buildInputField('E-mail', AntDesign.mail, _emailController),
            _buildInputField('Senha', AntDesign.lock, _passwordController,
                isPassword: true),
            _buildInputField('Telefone', AntDesign.phone, _phoneController),
          ],
        ),
      ),
    );
  }
}
