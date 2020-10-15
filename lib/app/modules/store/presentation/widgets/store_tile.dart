import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:ui' as ui;
import '../../../../app_controller.dart';
import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';

class StoreTile extends StatelessWidget {
  final String img;
  final String label;
  bool isSelected;
  final VoidCallback onTap;
  final int index;
  StoreTile({
    Key key,
    this.img = SUPERMARKET,
    this.label = '',
    this.isSelected = false,
    this.onTap,
    this.index,
  }) : super(key: key);

  _buildLabel(BuildContext context) => Container(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Positioned(
              top: 2.0,
              left: 2.0,
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'SofiaPro',
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 35,
                ).copyWith(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Text(label, style: TextStyle(
                  fontFamily: 'SofiaPro',
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w200,
                  fontSize: 35,
                )),
            ),
          ],
        ),
      );
  final AppController _controller = Modular.get<AppController>();
  Widget _buildContent(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Observer(builder: (_) {
          isSelected = _controller.selectedIndex == index;
          return Container(
            alignment: Alignment.bottomLeft,
            height: 200,
            width: getWidth(context),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                colorFilter: isSelected
                    ? ColorFilter.mode(
                        Colors.red[300].withOpacity(0.7),
                        BlendMode.color,
                      )
                    : null,
                fit: BoxFit.cover,
                image: FirebaseImage(img),
              ),
            ),
            child: _buildLabel(context),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}
