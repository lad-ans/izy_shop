import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:izy_shop/app/app_controller.dart';

import '../../core/domain/configs/core_config.dart';
import '../../core/presentation/widgets/amount_checkout_row.dart';
import '../../core/presentation/widgets/custom_statusbar.dart';
import '../../core/presentation/widgets/rounded_button.dart';
import '../../core/presentation/widgets/shopping_appbar.dart';
import 'checkout_controller.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState
    extends ModularState<CheckoutPage, CheckoutController> {
  final AppController _controller = Modular.get<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: getHeight(context),
      child: Stack(
        children: [
          SizedBox(height: getStatusBar(context)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 75 + getStatusBar(context)),
                  AmountCheckoutRow(title: 'Total Amount', amount: '23.350.00'),
                  Divider(),
                  Text('Select Payment', style: TextStyle(fontSize: 18.0)),
                  _buildPaymentMethodList(),
                  Divider(),
                  Text('Delivery Location', style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20),
                  _buildAddress(),
                  Divider(),
                  Text('Contacts', style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20),
                  _buildContact(),
                  Divider(),
                  Text('Delivery Time', style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20),
                  _buildDeliveryTime(),
                  Divider(),
                  Text('Any special instruction for delivery?',
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20),
                  _buildDeliveryInstructionTextField(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    alignment: Alignment.centerRight,
                    child: RoundedButton(
                        isGreenColor: true,
                        icon: Icons.check,
                        iconSize: 35.0,
                        text: 'Confirm',
                        btnWidth: 70.0,
                        btnHeight: 70.0,
                        width: 70.0,
                        textColor: Colors.black87,
                        textSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          CustomStatusBar(color: Colors.white),
          Padding(
            padding: EdgeInsets.only(top: getStatusBar(context)),
            child: ShoppingAppBar(fullAppBar: false),
          ),
        ],
      ),
    );
  }

  TextField _buildDeliveryInstructionTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Ex: Ring the outside bell when arrive...',
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        fillColor: Colors.black12,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black12, width: 0.6)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black12, width: 0.6)),
      ),
      maxLines: 3,
    );
  }

  Row _buildDeliveryTime() {
    return Row(
      children: [
        RoundedButton(
          color: Colors.black12,
          borderColor: Colors.black87,
          icon: Icons.timer,
          text: 'Choose\nTime',
          textColor: Colors.black,
          textSize: 13.0,
          btnWidth: 70.0,
          btnHeight: 70.0,
          width: 70.0,
          iconSize: 35,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('30min   -   1h'),
                    Expanded(child: SizedBox()),
                    Switch(
                      activeColor: Colors.green[200],
                      value: true,
                      onChanged: (value) {},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('2h   -   3h'),
                    Expanded(child: SizedBox()),
                    Switch(
                      activeColor: Colors.green[200],
                      value: false,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _buildContact() {
    return Row(
      children: [
        RoundedButton(
          color: Colors.black12,
          borderColor: Colors.black87,
          icon: Ionicons.ios_phone_portrait,
          text: 'New\nContact',
          textColor: Colors.black,
          textSize: 13.0,
          btnWidth: 70.0,
          btnHeight: 70.0,
          width: 70.0,
          iconSize: 35,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: '(+258) 84 123 45 67',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.symmetric()),
          ),
        )),
      ],
    );
  }

  Row _buildAddress() {
    return Row(
      children: [
        RoundedButton(
          color: Colors.black12,
          borderColor: Colors.black87,
          icon: Icons.location_on,
          text: 'New\nAddress',
          textColor: Colors.black,
          textSize: 13.0,
          btnWidth: 70.0,
          btnHeight: 70.0,
          width: 70.0,
          iconSize: 35,
          onTap: () async {
            _controller.select(4);
          },
          index: 4,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'Sommerschild, Maputo',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.symmetric()),
          ),
        )),
      ],
    );
  }

  Container _buildPaymentMethodList() {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          RoundedButton(
            color: Colors.black12,
            borderColor: Colors.black87,
            icon: Ionicons.ios_card,
            text: 'Pay\nOnline',
            textColor: Colors.black,
            textSize: 13.0,
            btnWidth: 70.0,
            btnHeight: 70.0,
            width: 70.0,
            iconSize: 35,
            onTap: () async {
              _controller.select(0);
            },
            index: 0,
          ),
          SizedBox(width: 7.0),
          RoundedButton(
            color: Colors.black12,
            borderColor: Colors.black87,
            icon: Icons.monetization_on,
            text: 'Bank\nTransfer',
            textColor: Colors.black,
            textSize: 13.0,
            btnWidth: 70.0,
            btnHeight: 70.0,
            width: 70.0,
            iconSize: 35,
            onTap: () async {
              _controller.select(1);
            },
            index: 1,
          ),
          SizedBox(width: 7.0),
          RoundedButton(
            color: Colors.black12,
            borderColor: Colors.black87,
            icon: Icons.phone_android,
            text: 'Payment of\nServices',
            textColor: Colors.black,
            textSize: 13.0,
            btnWidth: 70.0,
            btnHeight: 70.0,
            width: 70.0,
            iconSize: 35,
            onTap: () async {
              _controller.select(2);
            },
            index: 2,
          ),
          SizedBox(width: 7.0),
          RoundedButton(
            color: Colors.black12,
            borderColor: Colors.black87,
            icon: Icons.mobile_screen_share,
            text: 'POS\n',
            textColor: Colors.black,
            textSize: 13.0,
            btnWidth: 70.0,
            btnHeight: 70.0,
            width: 70.0,
            iconSize: 35,
            onTap: () async {
              _controller.select(3);
            },
            index: 3,
          ),
          SizedBox(width: 7.0),
          RoundedButton(
            color: Colors.black12,
            borderColor: Colors.black87,
            icon: FontAwesomeIcons.moneyBillAlt,
            text: 'Cash\n(on delivery)',
            textColor: Colors.black,
            textSize: 13.0,
            btnWidth: 70.0,
            btnHeight: 70.0,
            width: 70.0,
            iconSize: 35,
            onTap: () async {
              _controller.select(4);
            },
            index: 4,
          ),
        ],
      ),
    );
  }
}
