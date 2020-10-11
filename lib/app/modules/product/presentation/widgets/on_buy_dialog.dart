import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/entities/route_entity.dart';
import '../../../../core/domain/utils/number_formatter.dart';
import '../../../../core/presentation/widgets/custom_rich_text.dart';
import '../../../cart/presentation/stores/add_to_cart_store.dart';
import '../../../cart/presentation/stores/get_cart_store.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../data/models/product_model.dart';
import 'description_dialog.dart';

class OnBuyDialog extends StatelessWidget {
  final bool isSelected;
  final ProductModel productModel;
  final RouteEntity routeEntity;
  OnBuyDialog({
    Key key,
    this.isSelected = false,
    this.productModel,
    this.routeEntity,
  });

  final _getCartStore = Modular.get<GetCartStore>();
  final _addToCartStore = Modular.get<AddToCartStore>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white.withOpacity(0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildContentRow(),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _buildDialogButton(
                  height: 40.0,
                  width: 40.0,
                  color: Colors.red[200],
                  icon: AntDesign.info,
                  onTap: () {
                    Modular.to.pop();
                    showDialog(
                      context: context,
                      builder: (context) => DescriptionDialog(
                        shoRemovalButton: false,
                        productModel: productModel,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _buildDialogButton(
                  height: 40.0,
                  width: 40.0,
                  color: Colors.black38,
                  icon: Icons.close,
                  onTap: () => Modular.to.pop(),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: GestureDetector(
                onTap: () => Modular.to.pop(),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildDialogButton(
                    height: 50.0,
                    width: 50.0,
                    color: Colors.green,
                    icon: Icons.add_shopping_cart,
                    onTap: () {
                      List<ProductModel> cartList = _getCartStore.execute();
                      List<ProductModel> tempList = cartList
                          ?.where((e) => e.id == productModel.id)
                          ?.toList();
                      if (LoggedUser.instance.loggedUserUid != null) {
                        if (tempList.length == 0) {
                          _addToCartStore.execute(productModel);
                        } else {
                          EdgeAlert.show(
                            context,
                            title: 'Product exists',
                            description:
                                'This product already exists on your cart!',
                            gravity: EdgeAlert.TOP,
                            icon: Icons.info,
                            backgroundColor: Colors.amber.withOpacity(0.8),
                            duration: EdgeAlert.LENGTH_SHORT,
                          );
                        }
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
                      Modular.to.pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector _buildDialogButton(
      {double height,
      double width,
      Color color,
      IconData icon,
      VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50.0)),
          child: Icon(icon, color: Colors.white70, size: 30),
        ),
      ),
    );
  }

  Row _buildContentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumnLeft(),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 30.0),
          child: _buildColumnRight(),
        ),
      ],
    );
  }

  Column _buildColumnRight() {
    return Column(
      children: [
        Row(
          children: [
            CustomRichText(
              labelOne: 'Price: ',
              labelTwo:
                  '${NumberFormatter.instance.numToString(productModel?.price)} MT',
            ),
            Text(
              ' (unit)',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: () => Modular.to.pushNamed(
              'photo-view',
              arguments: RouteEntity(productModel: productModel),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: productModel.img,
              height: 150,
              width: 150,
            ),
          ),
        ),
        Divider(),
        Text(productModel.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Column _buildColumnLeft() {
    return Column(
      children: [
        Visibility(
          visible: productModel.hasSize,
          child: Text(
            'Select Size',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Visibility(
          visible: productModel?.hasSize,
          child: Row(
            children: [
              _buildItemSize(size: 'small'),
              SizedBox(width: 10.0),
              _buildItemSize(size: 'large', isSelected: true),
            ],
          ),
        ),
        Divider(),
        Visibility(
          visible: productModel.hasWeight || productModel.hasVol,
          child: Text('Select quantity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),

        /// if has weight
        Visibility(
          visible: productModel.hasWeight,
          child: Row(
            children: [
              _buildOnQtySelect(qty: '0.5kg'),
              _buildOnQtySelect(qty: '1kg', isSelected: true),
              _buildOnQtySelect(qty: '5kg'),
              _buildOnQtySelect(qty: '10kg'),
            ],
          ),
        ),

        /// if has volume
        Visibility(
          visible: productModel.hasVol,
          child: Row(
            children: [
              _buildOnQtySelect(qty: '1L'),
              _buildOnQtySelect(qty: '2L', isSelected: true),
              _buildOnQtySelect(qty: '5L'),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOnQtySelect({String qty, bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Text(qty),
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.green[200] : Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                width: 0.6,
                color: isSelected ? Colors.green[200] : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildItemSize({String size, bool isSelected = false}) {
    return Column(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green[200] : Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              width: 0.6,
              color: isSelected ? Colors.green[200] : Colors.black,
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: productModel.img,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              )),
        ),
        Text(size, style: TextStyle(fontSize: 12))
      ],
    );
  }
}
