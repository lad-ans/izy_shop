import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:izy_shop/app/app_controller.dart';
import 'package:izy_shop/app/core/domain/entities/route_entity.dart';

import '../../core/domain/configs/core_config.dart';
import '../../core/domain/consts/img.dart';
import '../store/data/models/market_model.dart';
import '../store/presentation/stores/get_market_store.dart';
import '../store/presentation/widgets/store_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      height: getHeight(context),
      width: getWidth(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(APPLE_WALLPAPER),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: _buildContainerContent(context),
      ),
    );
  }

  final marketStore = Modular.get<GetStoreStore>();
  final AppController _controller = Modular.get<AppController>();
  Widget _buildContainerContent(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Image.asset(LOGO_NAMED_WHITE, width: 90, height: 90),
          Expanded(
            child: Observer(builder: (_) {
              List<MarketModel> marketList = marketStore.marketList.data;
              if (marketStore.marketList.hasError) {
                return Center(child: Text('Ocorreu um erro'));
              }
              if (marketStore.marketList.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red[300]),
                ));
              }
              return ListView.builder(
                  itemCount: marketList.length,
                  itemBuilder: (context, index) {
                    MarketModel market = marketList[index];
                    return StoreTile(
                      img: market?.logo,
                      label: market?.name,
                      onTap: () async {
                        _controller.select(index);
                        await Modular.to.pushNamed(
                          '/store',
                          arguments: RouteEntity(storeName: market.name),
                        );
                        _controller.selectedIndex = 100;
                      },
                      index: index,
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
