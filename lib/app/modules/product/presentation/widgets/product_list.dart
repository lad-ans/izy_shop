import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/domain/consts/img.dart';
import '../../../../core/domain/entities/route_entity.dart';
import '../../../cart/presentation/stores/add_to_cart_store.dart';
import '../../data/models/product_model.dart';
import '../stores/get_product_store.dart';
import 'item_tile.dart';

class ProductList extends StatelessWidget {
  final double height;
  final String listTitle;
  final bool showListTitle;
  final RouteEntity routeEntity;

  ProductList({
    Key key,
    this.height,
    this.listTitle,
    this.showListTitle = true,
    this.routeEntity,
  }) {
    getProductStore.execute(routeEntity.storeRef);
  }

  final getProductStore = Modular.get<GetProductStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(visible: showListTitle, child: _buildTitle()),
        Container(
          height: height ?? 90.0,
          child: Observer(builder: (_) {
            List<ProductModel> productList = getProductStore.products.data;
            if (getProductStore.products.hasError) {
              print('Error Occured');
            }
            if (getProductStore.products.data == null) {
              return Container(
                alignment: Alignment.center,
                height: 20.0,
                child: SpinKitFadingCircle(size: 30.0, color: Colors.red[300]),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList
                  ?.where((el) =>
                      el.category.toLowerCase() == listTitle.toLowerCase())
                  ?.toList()
                  ?.length,
              itemBuilder: (context, index) {
                ProductModel productModel = productList
                    .where((el) =>
                        el.category.toLowerCase() == listTitle.toLowerCase())
                    .toList()[index];

                productModel.storeCategory =
                    routeEntity.storeCategory.toLowerCase();
                productModel.storeName = routeEntity.storeName;
                return LongPressDraggable(
                  data: productModel,
                  maxSimultaneousDrags: 1,
                  feedback: _buildDraggableFeedback(productModel),
                  child: ItemTile(
                    productModel: productModel,
                    color: Theme.of(context).cardColor,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDraggableFeedback(ProductModel productModel) {
    return Opacity(
      opacity: 0.9,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Observer(builder: (_) {
          final currentColor = Modular.get<AddToCartStore>().dragFeedbackColor;
          return Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    productModel?.img ?? IMG_DEFAULT),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(currentColor, BlendMode.color),
              ),
            ),
          );
        }),
      ),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Text(
        listTitle.toUpperCase() ?? '',
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
