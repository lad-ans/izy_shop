import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../modules/product/data/models/product_model.dart';
import '../../../modules/product/presentation/stores/get_product_store.dart';
import '../../../modules/product/presentation/widgets/on_buy_dialog.dart';
import '../../domain/configs/core_config.dart';
import '../../domain/consts/img.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/utils/number_formatter.dart';

class SearchPage extends StatelessWidget {
  final RouteEntity _routeEntity;
  SearchPage(
    this._routeEntity,
  ) {
    getProductStore.execute(_routeEntity.storeRef);
  }

  String searchParam = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  final getProductStore = Modular.get<GetProductStore>();
  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, getStatusBar(context), 20.0, 20.0),
      height: getHeight(context),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(APPLE_WALLPAPER))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: getStatusBar(context) + 60.0 + 60.0),
              child: _buildListView(),
            ),
            _buildCloseButton(),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: _buildTextField(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(
      {BuildContext context,
      String product,
      String title,
      num price,
      String vendor,
      ProductModel productModel}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return OnBuyDialog(
                productModel: productModel,
              );
            },
          ),
          child: Container(
            width: 100.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(product),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          productModel.hasSize || productModel.hasVol || productModel.hasWeight
              ? 'custom price'
              : '${NumberFormatter.instance.numToString(price)} MT',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(imageUrl: vendor, width: 100.0)),
      ),
    );
  }

  Container _buildListView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Observer(builder: (_) {
        List<ProductModel> productList = getProductStore.products.data;
        if (getProductStore.products.hasError) {
          print('Error Occured');
        }
        if (getProductStore.products.data == null) {
          return Container(
              alignment: Alignment.center,
              height: 20.0,
              child: SpinKitFadingCircle(size: 30.0, color: Colors.white));
        }
        return ListView.builder(
          itemCount: productList
              .where((item) => item.name.toLowerCase().contains(
                    searchParam.toLowerCase(),
                  ))
              .toList()
              .length,
          itemBuilder: (context, index) {
            ProductModel productModel = productList
                .where((item) => item.name.toLowerCase().contains(
                      searchParam.toLowerCase(),
                    ))
                .toList()[index];
            return _buildItemTile(
              context: context,
              productModel: productModel,
              product: productModel.img,
              title: productModel.name,
              price: productModel.price,
              vendor: _routeEntity.storeImg,
            );
          },
        );
      }),
    );
  }

  TextField _buildTextField() {
    return TextField(
      style: TextStyle(color: Colors.black54, fontSize: 18.0),
      onChanged: (value) {
        this.searchParam = value;
      },
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.black54, fontSize: 18.0),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            AntDesign.search1,
            color: Colors.black54,
            size: 35.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white60, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white60, width: 0.7),
        ),
      ),
    );
  }

  Positioned _buildCloseButton() {
    return Positioned(
      right: 0.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: () => Modular.to.pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(40.0)),
            child: Icon(
              Icons.close,
              size: 30.0,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
