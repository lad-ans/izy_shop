import 'package:flutter/material.dart';

import '../../../../core/domain/consts/img.dart';
import 'item_tile.dart';

class ProductList extends StatelessWidget {
  final double height;
  final String listTitle;
  final bool showListTitle;
  const ProductList({
    Key key,
    this.height,
    this.listTitle,
    this.showListTitle = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(visible: showListTitle, child: _buildTitle()),
        Container(
          height: height ?? 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ItemTile(color: Theme.of(context).cardColor, product: APPLES),
              ItemTile(color: Theme.of(context).cardColor, product: PAPAYA),
              ItemTile(color: Theme.of(context).cardColor, product: RICE),
              ItemTile(color: Theme.of(context).cardColor, product: YOGURT),
              ItemTile(color: Theme.of(context).cardColor, product: BEANS),
              ItemTile(color: Theme.of(context).cardColor, product: MEAT),
              ItemTile(color: Theme.of(context).cardColor, product: POTATOES),
              ItemTile(color: Theme.of(context).cardColor, product: RICE),
              ItemTile(color: Theme.of(context).cardColor, product: BEANS),
              ItemTile(color: Theme.of(context).cardColor, product: APPLES),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        listTitle ?? 'Arroz',
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
