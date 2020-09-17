import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static final UrlLauncher instance = UrlLauncher._launchUrl();

  factory UrlLauncher() {
    return instance;
  }

  UrlLauncher._launchUrl();

  launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  launchPhoneCall({@required String phone}) {
    launch("tel://${phone.toString()}");
  }
}
