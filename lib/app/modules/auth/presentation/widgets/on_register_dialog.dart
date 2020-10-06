import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';

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
              onTap: () {
                EdgeAlert.show(
                  context,
                  title: 'Logged in successfully',
                  description: 'Great!! You are logged in',
                  gravity: EdgeAlert.BOTTOM,
                  icon: Icons.check,
                  backgroundColor: Colors.green,
                  duration: EdgeAlert.LENGTH_SHORT,
                );
                Modular.to.pushReplacementNamed('/home/city');
              },
              isGreenColor: true,
            ),
          ],
        ),
      ],
    );
  }
}
