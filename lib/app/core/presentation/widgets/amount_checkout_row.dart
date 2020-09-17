import 'package:flutter/material.dart';

import '../../configs/core_config.dart';

class AmountCheckoutRow extends StatelessWidget {
  final String title;
  final String amount;
  const AmountCheckoutRow({
    Key key,
    this.title = 'Title',
    this.amount = '0,00',
  }) : super(key: key);
  Row _buildAmountCheckOut(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: getWidth(context) / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckOutAmountTitle(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildColoredText(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text _buildCheckOutAmountTitle() {
    return Text('$title:', style: TextStyle(fontWeight: FontWeight.bold));
  }

  Text _buildColoredText() => Text(
        amount + ' MT',
        style: TextStyle(
          color: Colors.red[300],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildAmountCheckOut(context);
  }
}
