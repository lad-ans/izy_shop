import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/entities/route_entity.dart';
import '../../../cart/data/datasources/cart_data_source.dart';
import '../../data/models/product_model.dart';

class DescriptionDialog extends StatelessWidget {
  final bool isSelected;
  final bool isFromNet;
  final ProductModel productModel;
  final bool shoRemovalButton;
  DescriptionDialog({
    Key key,
    this.isSelected = false,
    this.isFromNet = false,
    this.productModel,
    this.shoRemovalButton = true,
  }) : super(key: key);

  final _cartDataSource = Modular.get<CartDataSource>();
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
            _buildContentRow(context),
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
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Visibility(
                visible: shoRemovalButton,
                child: GestureDetector(
                  onTap: () => Modular.to.pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _buildRemovalButton(
                      onPressed: () {
                        _cartDataSource.removeFromCart(productModel);
                        Modular.to.pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  FlatButton _buildRemovalButton({VoidCallback onPressed}) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.remove_shopping_cart,
        color: Colors.red[300],
        size: 30.0,
      ),
      label: Text(
        'Remove',
        style: TextStyle(
          color: Colors.red[200],
          fontSize: 10.0,
        ),
      ),
    );
  }

  GestureDetector _buildDialogButton({
    double height,
    double width,
    Color color,
    IconData icon,
  }) {
    return GestureDetector(
      onTap: () => Modular.to.pop(),
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
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildColumnLeft(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 40.0),
            child: _buildColumnRight(),
          ),
        ],
      ),
    );
  }

  Column _buildColumnRight() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: () => Modular.to.pushNamed(
              'photo-view',
              arguments: RouteEntity(productModel: productModel),
            ),
            child: Image(
              image: FirebaseImage(productModel.img),
              width: 150.0,
              height: 150.0,
              fit: BoxFit.cover,
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
        Text(
          'About the product',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Container(
          child: Text(
            productModel.description ?? 'No description!',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
