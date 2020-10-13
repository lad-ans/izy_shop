import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/entities/route_entity.dart';
import '../../../../core/domain/utils/number_formatter.dart';
import '../../../../core/presentation/widgets/custom_rich_text.dart';
import '../../../cart/data/datasources/cart_data_source.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../data/models/product_model.dart';
import '../stores/get_price_by_key_store.dart';
import 'description_dialog.dart';

class OnBuyDialog extends StatelessWidget {
  final ProductModel productModel;
  final RouteEntity routeEntity;
  OnBuyDialog({
    Key key,
    this.productModel,
    this.routeEntity,
  });

  final _cartDataSource = Modular.get<CartDataSource>();
  final _getPriceByKeyStore = Modular.get<GetPriceByKeyStore>();

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
                      Map<String, dynamic> _selectedItem = {
                        _getPriceByKeyStore.selectedCustomPriceKey:
                            _getPriceByKeyStore.selectedCustomPriceValue
                      };
                      List<ProductModel> cartList =
                          _cartDataSource.customerCart;

                      /// setup temp list
                      List<ProductModel> tempList = cartList?.where((item) {
                        if (productModel.hasSize ||
                            productModel.hasVol ||
                            productModel.hasWeight) {
                          return mapEquals(item.selectedItem, _selectedItem);
                        } else {
                          return item.id == productModel.id;
                        }
                      })?.toList();

                      if (LoggedUser.instance.loggedUserUid != null) {
                        /// condition to add to cart
                        if (tempList?.length == 0) {
                          /// set selected item
                          productModel.selectedItem = _selectedItem;
                          if (productModel.selectedItem.values.first == null) {
                            EdgeAlert.show(
                              context,
                              title: 'Select price',
                              description: 'Please select price!',
                              gravity: EdgeAlert.TOP,
                              icon: Icons.info,
                              backgroundColor: Colors.amber.withOpacity(0.9),
                              duration: EdgeAlert.LENGTH_VERY_LONG,
                            );
                          } else {
                            _cartDataSource.addToCart(productModel);
                            print(_cartDataSource.customerCart);
                          }
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

  _buildDialogButton(
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

  _buildContentRow() {
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

  _buildColumnRight() {
    return Column(
      children: [
        Observer(builder: (_) {
          return CustomRichText(
              labelOne: 'Price: ',
              labelTwo: productModel.hasSize ||
                      productModel.hasVol ||
                      productModel.hasWeight
                  ? _getPriceByKeyStore.customPrice == 0
                      ? 'select item'
                      : '${NumberFormatter.instance.numToString(_getPriceByKeyStore.customPrice).toString()} MT'
                  : '${NumberFormatter.instance.numToString(productModel.price).toString()} MT');
        }),
        Observer(builder: (_) {
          return Visibility(
            visible: _getPriceByKeyStore.customPrice != 0,
            child: Text(
              ' (unit)',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          );
        }),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(productModel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  _buildColumnLeft() {
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
          visible: productModel.hasSize,
          child: productModel.hasSize
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: productModel?.customPrice?.keys
                      ?.map<Widget>(
                          (key) => _buildItemSize(size: key, key: key))
                      ?.toList(),
                )
              : Container(),
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
          child: productModel.hasWeight
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: productModel?.customPrice?.keys
                      ?.map<Widget>(
                          (key) => _buildOnQtySelect(qty: key, key: key))
                      ?.toList(),
                )
              : Container(),
        ),

        /// if has volume
        Visibility(
          visible: productModel.hasVol,
          child: productModel.hasVol
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: productModel?.customPrice?.keys
                      ?.map<Widget>(
                          (key) => _buildOnQtySelect(qty: key, key: key))
                      ?.toList(),
                )
              : Container(),
        )
      ],
    );
  }

  _buildOnQtySelect({String qty, bool isSelected = false, String key}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Text(
            qty.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Observer(builder: (_) {
            return InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () {
                _getPriceByKeyStore.selectKey(key, productModel.customPrice);
              },
              child: Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  color: _getPriceByKeyStore.keyReceiver == key
                      ? Colors.green[200]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    width: 0.6,
                    color: isSelected ? Colors.green[200] : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  _buildItemSize({String size, String key}) {
    return InkWell(
      onTap: () {
        _getPriceByKeyStore.selectKey(key, productModel.customPrice);
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Observer(builder: (_) {
              return Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: _getPriceByKeyStore.keyReceiver == key
                      ? Colors.green[200]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    width: 0.6,
                    color: _getPriceByKeyStore.keyReceiver == key
                        ? Colors.green[200]
                        : Colors.black,
                  ),
                ),
                child: Observer(builder: (_) {
                  return Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          productModel.img,
                        ),
                        colorFilter: _getPriceByKeyStore.keyReceiver == key
                            ? ColorFilter.mode(
                                Colors.red[300].withOpacity(0.7),
                                BlendMode.color,
                              )
                            : null,
                      ),
                    ),
                  );
                }),
              );
            }),
            SizedBox(height: 5.0),
            Text(
              size.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
