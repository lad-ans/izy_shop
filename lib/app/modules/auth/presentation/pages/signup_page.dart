import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:izy_shop/app/app_controller.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../widgets/custom_textfield.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
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
          child: _buildListView(context)),
    );
  }

  final AppController _controller = Modular.get<AppController>();
  Widget _buildListView(BuildContext context) {
    return ListView(
      children: [
        Image.asset(LOGO_NAMED_WHITE, width: 120, height: 120),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
              iconColor: Colors.white,
              icon: Zocial.facebook,
              text: 'Login With Facebook',
              onTap: () async {
                _controller.select(0);
                // await Modular.to.pushReplacementNamed('/home/city');
                // _controller.select(100);
              },
              index: 0,
            ),
            SizedBox(width: 20.0),
            RoundedButton(
              iconColor: Colors.white,
              icon: Zocial.google,
              text: 'Login With Google',
              onTap: () async {
                _controller.select(1);
                // await Modular.to.pushReplacementNamed('/home/city');
                // _controller.select(100);
              },
              index: 1,
            ),
          ],
        ),
        SizedBox(height: 30.0),
        _buildOr(context),
        SizedBox(height: 15.0),
        _buildCustomerDetails(),
        SizedBox(height: 10.0),
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
        SizedBox(height: 10.0),
        CustomTextField(
          height: 55.0,
          fillColor: Colors.white,
          labelText: 'Confirm Password',
          filled: true,
        ),
        SizedBox(height: 15.0),
        _buildOnConfirm(context),
        SizedBox(height: 20.0),
      ],
    );
  }

  Container _buildOnConfirm(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: RoundedButton(
        icon: FontAwesomeIcons.check,
        text: 'Confirm',
        isGreenColor: true,
        onTap: () => showDialog(
          context: context,
          builder: (context) => OnRegisterDetailsDialog(
            title: 'Please confirm your details below',
            firstName: 'Carlos',
            lastName: 'Bernardo',
            email: 'carlos.b@gmail.com',
          ),
        ),
      ),
    );
  }

  Row _buildCustomerDetails() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            height: 55.0,
            fillColor: Colors.white,
            labelText: 'First Name',
            filled: true,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: CustomTextField(
            height: 55.0,
            fillColor: Colors.white,
            labelText: 'Last Name',
            filled: true,
          ),
        ),
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

class OnRegisterDetailsDialog extends StatelessWidget {
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  const OnRegisterDetailsDialog({
    Key key,
    this.title,
    this.firstName,
    this.lastName,
    this.email,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Text(title,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0)),
      children: [
        SizedBox(height: 20.0),
        Text('Name: $firstName $lastName',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 10.0),
        Text('E-mail: $email',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              iconColor: Colors.white,
              icon: AntDesign.edit,
              onTap: () => Modular.to.pop(),
            ),
            SizedBox(width: 20.0),
            RoundedButton(
              iconColor: Colors.white,
              icon: FontAwesomeIcons.check,
              onTap: () => Modular.to.pushReplacementNamed('/home/city'),
              isGreenColor: true,
            ),
          ],
        ),
      ],
    );
  }
}
