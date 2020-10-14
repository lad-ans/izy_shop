import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends StatelessWidget {
  _buidBody() {
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: SpinKitCircle(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buidBody();
  }
}
