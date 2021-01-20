import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/configs/core_config.dart';
import '../../domain/utils/url_launcher.dart';

class HelpDialog extends StatelessWidget {
  final bool isSelected;
  const HelpDialog({
    Key key,
    this.isSelected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white.withOpacity(0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      children: [
        _buildContentDialog(context),
      ],
    );
  }

  Widget _buildContentDialog(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: getWidth(context) * 0.6,
      child: _buildContentColumn(),
    );
  }

  Widget _buildContentColumn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Assistence',
          style: TextStyle(
              fontSize: 19,
              color: Colors.red[300],
              fontWeight: FontWeight.bold),
        ),
        InkWell(
            onTap: () async {
              UrlLauncher.instance.launchPhoneCall(phone: '+258841234567');
            },
            borderRadius: BorderRadius.circular(70.0),
            child: Icon(FontAwesomeIcons.headset)),
      ],
    );
  }
}
