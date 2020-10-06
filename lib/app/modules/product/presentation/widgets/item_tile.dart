import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/modules/cart/domain/usecases/get_customer_cart.dart';
import 'package:izy_shop/app/modules/cart/presentation/stores/cart_module_stores.dart';

import '../../../../core/domain/utils/number_formatter.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../data/models/product_model.dart';
import '../stores/add_to_cart_store.dart';
import 'cart_product_dialog.dart';
import 'description_dialog.dart';
import 'on_buy_dialog.dart';

class ItemTile extends StatelessWidget {
  final ProductModel productModel;
  final Color color;
  final double elevation;
  final double hPadd;
  final bool showItemPrice;
  final String productImg;
  final double itemWidth;
  final bool isOnBasket;
  final bool isOnCart;

  ItemTile(
      {this.color,
      this.elevation,
      this.hPadd,
      this.showItemPrice = true,
      this.productImg,
      this.itemWidth,
      this.isOnBasket = false,
      this.isOnCart = false,
      this.productModel});

  final _getCustomerCartStore = Modular.get<GetCustomerCartStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: isOnBasket
                ? (context) => DescriptionDialog(
                      productModel: productModel,
                    )
                : isOnCart
                    ? (context) => CartProductDialog(
                          productModel: productModel,
                        )
                    : (context) => OnBuyDialog(
                          productModel: productModel,
                        ));
      },
      child: Container(
        child: Stack(
          children: [
            _buildImgTile(),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: _buildItemPrice(),
            ),
            Positioned(
              bottom: 5.0,
              right: 5.0,
              child: _buildAddToCartButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImgTile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: color ?? Colors.transparent,
        elevation: elevation ?? 0.4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          width: itemWidth ?? 90,
          padding: EdgeInsets.symmetric(vertical: 1.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                  imageUrl: isOnCart ? productImg : productModel?.img,
                  fit: BoxFit.contain)),
        ),
      ),
    );
  }

  final _addToCart = Modular.get<AddToCartStore>();
  Widget _buildAddToCartButton(BuildContext context) {
    return Visibility(
      visible: showItemPrice,
      child: InkWell(
        child: Material(
          elevation: 6.0,
          color: Colors.white60,
          borderRadius: BorderRadius.circular(70.0),
          child: Center(
            child: Icon(
              Ionicons.ios_add_circle,
              color: Colors.green[200],
            ),
          ),
        ),
        onTap: () async {
          if (LoggedUser.instance.loggedUserUid != null) {
            // List<ProductModel> cartList = _getCustomerCartStore.cartList.data;
            // cartList.forEach((item) async {
            //   if (item.id != productModel.id) {
            await _addToCart.execute(productModel);
            //   } else {
            //     EdgeAlert.show(
            //       context,
            //       title: 'Product exist',
            //       description: 'This product is present on cart',
            //       gravity: EdgeAlert.BOTTOM,
            //       icon: Icons.info,
            //       backgroundColor: Colors.amber,
            //       duration: EdgeAlert.LENGTH_SHORT,
            //     );
            //   }
            // });
          } else {
            EdgeAlert.show(
              context,
              title: 'No user found',
              description: 'Login to buy item',
              gravity: EdgeAlert.BOTTOM,
              icon: Icons.info,
              backgroundColor: Colors.redAccent,
              duration: EdgeAlert.LENGTH_SHORT,
            );
          }
        },
      ),
    );
  }

  Widget _buildItemPrice() {
    return Visibility(
      visible: showItemPrice,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${NumberFormatter.instance.numToString(productModel?.price)} MT',
              style: TextStyle(
                color: Colors.red[200],
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
