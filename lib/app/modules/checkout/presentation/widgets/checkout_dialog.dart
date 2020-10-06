import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app_controller.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../cart/presentation/stores/cart_module_stores.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../../product/data/models/product_model.dart';

class CheckoutDialog extends StatelessWidget {
  final bool isSelected;
  CheckoutDialog({
    Key key,
    this.isSelected = false,
  }) {
    _getCustomerCartStore.execute(LoggedUser.instance.loggedUserUid);
  }

  final _controller = Modular.get<AppController>();
  final _getCustomerCartStore = Modular.get<GetCustomerCartStore>();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white.withOpacity(0.75),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildContentRow(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
      height: 250.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ORDER COMPLETE \nThank You!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 22.0),
          ),
          Expanded(child: SizedBox()),
          RoundedButton(
            icon: AntDesign.search1,
            iconColor: Colors.white70,
            text: 'Search Products',
            textColor: Colors.black54,
            onTap: () {
              _controller.select(9);
              List<ProductModel> cartList = _getCustomerCartStore.cartList.data;
              cartList.forEach((item) {
                return item.reference.delete();
              });
              Modular.to.pushReplacementNamed('/home');
            },
            index: 9,
          ),
        ],
      ),
    );
  }
}
