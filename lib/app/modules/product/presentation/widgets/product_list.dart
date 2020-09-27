import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/entities/route_entity.dart';
import '../../data/models/product_model.dart';
import '../stores/get_product_by_category_store.dart';
import 'item_tile.dart';

class ProductList extends StatefulWidget {
  final double height;
  final String listTitle;
  final bool showListTitle;
  final RouteEntity routeEntity;
  final Function(ProductModel) onAddToCart;

  ProductList({
    Key key,
    this.height,
    this.listTitle,
    this.showListTitle = true,
    this.routeEntity,
    this.onAddToCart,
  }) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    getProductByCategoryStore.execute(
        widget.routeEntity.storeRef, widget.routeEntity.productCategories);
    super.initState();
  }

  final GetProductByCategoryStore getProductByCategoryStore =
      Modular.get<GetProductByCategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(visible: widget.showListTitle, child: _buildTitle()),
        Container(
          height: widget.height ?? 90.0,
          child: Observer(builder: (_) {
            List<ProductModel> productList =
                getProductByCategoryStore.products.data;
            if (getProductByCategoryStore.products.hasError) {
              print('Error Occured');
            }
            if (getProductByCategoryStore.products.data == null) {
              return Container(
                  alignment: Alignment.center,
                  height: 20.0,
                  child: CircularProgressIndicator());
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList
                  .where((el) =>
                      el.category.toLowerCase() ==
                      widget.listTitle.toLowerCase())
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                ProductModel product = productList
                    .where((el) =>
                        el.category.toLowerCase() ==
                        widget.listTitle.toLowerCase())
                    .toList()[index];
                widget.onAddToCart(product);
                return ItemTile(
                  productModel: product,
                  color: Theme.of(context).cardColor,
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Text(
        widget.listTitle.toUpperCase() ?? '',
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
