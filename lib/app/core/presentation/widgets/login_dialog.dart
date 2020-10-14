import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/configs/core_config.dart';

class LoginDialog extends StatelessWidget {
  _buildDialogButton(
      {double height,
      double width,
      Color color,
      IconData icon,
      VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50.0)),
          child: Icon(icon, color: Colors.white70, size: 30),
        ),
      ),
    );
  }

  _buidBody() {
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Stack(
        children: [
          Container(
            height: 50.0,
            child: RaisedButton.icon(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.green,
              onPressed: () async {
                setAllOrientations();
                await Modular.to.pushNamed('/auth');
                setLandscapeOrientation();
              },
              icon: Icon(
                Ionicons.ios_log_in,
                color: Colors.white,
              ),
              label: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: _buildDialogButton(
                height: 40.0,
                width: 40.0,
                color: Colors.black38,
                icon: Icons.close,
                onTap: () => Modular.to.pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buidBody();
  }
}
