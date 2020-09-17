import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'customer_controller.dart';

class CustomerPage extends StatefulWidget {
  final String title;
  const CustomerPage({Key key, this.title = "Customer"}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState
    extends ModularState<CustomerPage, CustomerController> {
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
