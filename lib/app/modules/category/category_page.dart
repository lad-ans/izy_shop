import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'category_controller.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  const CategoryPage({Key key, this.title = "Category"}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState
    extends ModularState<CategoryPage, CategoryController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
