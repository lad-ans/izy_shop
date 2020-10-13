import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../domain/configs/core_config.dart';
import '../../domain/entities/route_entity.dart';

class PhotoViewPage extends StatelessWidget {
  final RouteEntity _routeEntity;
  const PhotoViewPage(
    this._routeEntity,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: getWidth(context),
            height: getHeight(context),
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(
                _routeEntity.productModel.img,
              ),
            ),
          ),
          Container(
            height: 60.0,
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                _routeEntity.productModel.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
