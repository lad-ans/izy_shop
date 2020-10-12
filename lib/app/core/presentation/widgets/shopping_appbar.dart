import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/cart/data/datasources/cart_data_source.dart';
import '../../../modules/customer/domain/entities/logged_user.dart';
import '../../../modules/product/data/models/product_model.dart';
import '../../domain/configs/core_config.dart';
import '../../domain/consts/img.dart';
import '../../domain/entities/route_entity.dart';
import 'help_dialog.dart';

class ShoppingAppBar extends StatefulWidget {
  final bool fullAppBar;
  final RouteEntity routeEntity;
  final bool onNavigate;
  final bool onBack;
  const ShoppingAppBar({
    Key key,
    this.fullAppBar = true,
    this.routeEntity,
    this.onNavigate = false,
    this.onBack = false,
  }) : super(key: key);

  @override
  _ShoppingAppBarState createState() => _ShoppingAppBarState();
}

class _ShoppingAppBarState extends State<ShoppingAppBar> {
  final _cartDataSource = Modular.get<CartDataSource>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: !widget.fullAppBar ? 50.0 : 65,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      width: getWidth(context),
      child: Row(
        children: [
          Observer(builder: (_) {
            List<ProductModel> cartList = _cartDataSource.customerCart;
            return _buildRoundedButton(Icons.arrow_back, label: 'Back',
                onTap: () {
              if (widget.onBack) {
                if (cartList.length > 0) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white70,
                      title: Text('This action will clear your cart!'),
                      titleTextStyle: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            if (widget.onNavigate) {
                              _cartDataSource.removeAll();
                            }
                            Modular.to.pop();
                            Modular.to.pop();
                          },
                          child: Text('Continue'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Modular.to.pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              Modular.to.pop();
            });
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
                  label: 'Filters', onTap: () {}, isFilter: true)),
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
                if (widget.onNavigate) setLandscapeOrientation();
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
                  barrierDismissible: false,
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

  _buildAlertDialog() {
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Stack(
        children: [
          Container(
            height: 50.0,
            child: RaisedButton.icon(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.green,
              onPressed: () async {
                setAllOrientations();
                await Modular.to.pushNamed('/auth');
                setLandscapeOrientation();
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
        ],
      ),
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
        elevation: 2.0,
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

  _buildNavigatorLogo() => Observer(builder: (_) {
        List<ProductModel> cartList = _cartDataSource.customerCart;
        return InkWell(
            onTap: () {
              if (widget.onNavigate) {
                if (cartList.length > 0) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white70,
                      title: Text('This action will clear your cart!'),
                      titleTextStyle: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            if (widget.onNavigate) {
                              _cartDataSource.removeAll();
                            }
                            Modular.to.pop();
                            Modular.to.pushReplacementNamed('/home');
                          },
                          child: Text('Continue'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Modular.to.pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              Modular.to.pushReplacementNamed('/home');
            },
            child: Image.asset(LOGO, height: !widget.fullAppBar ? 45.0 : 55.0));
      });

  Widget _buildNavigationText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: ' ${widget.routeEntity.storeCategory} / Departaments / ',
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

  _buildRoundedButtonLabel(String label, {bool isFilter = false}) => Container(
        width: !widget.fullAppBar ? 30.0 : 45,
        child: Text(
          label ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isFilter ? Colors.black26 : Colors.black,
            fontSize: !widget.fullAppBar ? 8.0 : 12.0,
          ),
        ),
      );

  _buildRoundedButton(IconData icon,
      {VoidCallback onTap, String label, bool isFilter = false}) {
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
                  color: isFilter ? Colors.black26 : Colors.black45,
                  borderRadius:
                      BorderRadius.circular(widget.fullAppBar ? 30.0 : 45.0)),
              child: Icon(icon,
                  size: !widget.fullAppBar ? 20 : 30.0,
                  color: isFilter ? Colors.white38 : Colors.white),
            ),
            _buildRoundedButtonLabel(label, isFilter: isFilter),
          ],
        ),
      ),
    );
  }
}
