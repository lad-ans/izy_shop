import 'package:flutter/material.dart';

import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';


class StoreTile extends StatelessWidget {
  final String img;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const StoreTile({
    Key key,
    this.img = SUPERMARKET,
    this.label = '',
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  Widget _buildLabel() => Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Sans',
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 40,
          ),
        ),
      );

  Widget _buildContent(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Container(
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
              image: AssetImage(img),
            ),
          ),
          child: _buildLabel(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}
