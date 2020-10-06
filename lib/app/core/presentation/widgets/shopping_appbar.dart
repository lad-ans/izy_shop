import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/cart/presentation/stores/get_customer_cart_store.dart';
import '../../../modules/customer/domain/entities/logged_user.dart';
import '../../../modules/product/data/models/product_model.dart';
import '../../domain/configs/core_config.dart';
import '../../domain/consts/img.dart';
import '../../domain/entities/route_entity.dart';
import 'help_dialog.dart';

class ShoppingAppBar extends StatefulWidget {
  final bool fullAppBar;
  final bool isCartPage;
  final RouteEntity routeEntity;
  final bool isShopping;
  const ShoppingAppBar({
    Key key,
    this.fullAppBar = true,
    this.isCartPage = false,
    this.routeEntity,
    this.isShopping = false,
  }) : super(key: key);

  @override
  _ShoppingAppBarState createState() => _ShoppingAppBarState();
}

class _ShoppingAppBarState extends State<ShoppingAppBar> {
  final _getCustomerCartStore = Modular.get<GetCustomerCartStore>();

  @override
  void initState() {
    _getCustomerCartStore.execute(LoggedUser.instance.loggedUserUid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: !widget.fullAppBar ? 50.0 : 65,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      width: getWidth(context),
      child: Row(
        children: [
          _buildRoundedButton(Icons.arrow_back, label: 'Back', onTap: () {
            if (widget.isShopping) {
              List<ProductModel> cartList = _getCustomerCartStore.cartList.data;
              cartList.forEach((item) {
                return item.reference.delete();
              });
            }
            Modular.to.pop();
          }),
          SizedBox(width: 2.0),
          _buildNavigatorLogo(),
          SizedBox(width: 2.0),
          Visibility(
              visible: widget.fullAppBar,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                          imageUrl: widget.routeEntity.storeImg,
                          height: widget.fullAppBar ? 30.0 : 55.0) ??
                      Image.asset(APPLES))),
          SizedBox(width: 2.0),
          Visibility(visible: widget.fullAppBar, child: _buildNavigationText()),
          Expanded(child: SizedBox()),
          Visibility(
            visible: widget.fullAppBar,
            child: _buildRoundedButton(
              Icons.search,
              label: 'Search',
              onTap: () {
                Modular.to.pushNamed(
                  '/search',
                  arguments: RouteEntity(
                      storeImg: widget.routeEntity.storeImg,
                      storeRef: widget.routeEntity.storeRef),
                );
              },
            ),
          ),
          SizedBox(width: 2.0),
          Visibility(
              visible: widget.fullAppBar,
              child: _buildRoundedButton(AntDesign.filter,
                  label: 'Filters', onTap: () {})),
          SizedBox(width: 2.0),
          _buildRoundedButton(
            AntDesign.question,
            label: 'Help',
            onTap: () => showDialog(
              context: context,
              builder: (_) => HelpDialog(),
            ),
          ),
          SizedBox(width: 2.0),
          _buildRoundedButton(
            AntDesign.user,
            label: 'Profile',
            onTap: () async {
              if (LoggedUser.instance.loggedUserUid != null) {
                setAllOrientations();
                await Modular.to.pushNamed('/customer');
                setLandscapeOrientation();
              } else {
                EdgeAlert.show(
                  context,
                  title: 'No user found',
                  description: 'Login to show user info',
                  gravity: EdgeAlert.BOTTOM,
                  icon: Icons.info,
                  backgroundColor: Colors.redAccent,
                  duration: EdgeAlert.LENGTH_SHORT,
                );
                showDialog(
                  context: context,
                  builder: (context) => _buildAlertDialog(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  AlertDialog _buildAlertDialog() {
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Container(
        height: 50.0,
        child: RaisedButton.icon(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.red[300],
          onPressed: () {
            Modular.to.pushNamed('/auth');
          },
          icon: Icon(
            Ionicons.ios_log_in,
            color: Colors.white,
          ),
          label: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigatorLogo() => InkWell(
      onTap: () {
        setAllOrientations();
        Modular.to.pushReplacementNamed('/home');
      },
      child: Image.asset(LOGO, height: !widget.fullAppBar ? 45.0 : 55.0));

  Widget _buildNavigationText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: ' ${widget.routeEntity.storeName} / Departaments / ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Products',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Column _buildGold() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         'gold'.toUpperCase(),
  //         style: TextStyle(
  //           color: Colors.amber,
  //           fontSize: !widget.fullAppBar ? 18 : 25.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           _buildStar(),
  //           _buildStar(),
  //           _buildStar(),
  //           _buildStar(),
  //           _buildStar(),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Icon _buildStar() {
  //   return Icon(
  //     Ionicons.ios_star,
  //     size: !widget.fullAppBar ? 10.0 : 14.0,
  //     color: Colors.amber,
  //   );
  // }

  Widget _buildRoundedButtonLabel(String label) => Container(
        width: !widget.fullAppBar ? 30.0 : 45,
        child: Text(
          label ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: !widget.fullAppBar ? 8.0 : 12.0,
          ),
        ),
      );

  Widget _buildRoundedButton(IconData icon,
      {VoidCallback onTap, String label}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(45.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: [
            Container(
                height: !widget.fullAppBar ? 40.0 : 45.0,
                width: !widget.fullAppBar ? 40.0 : 45.0,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius:
                        BorderRadius.circular(widget.fullAppBar ? 30.0 : 45.0)),
                child: Icon(icon,
                    size: !widget.fullAppBar ? 20 : 30.0, color: Colors.white)),
            _buildRoundedButtonLabel(label),
          ],
        ),
      ),
    );
  }
}
