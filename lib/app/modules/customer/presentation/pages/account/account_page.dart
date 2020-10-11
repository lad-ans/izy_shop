import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/domain/configs/core_config.dart';
import '../../../../../core/domain/consts/img.dart';
import '../../../../../core/presentation/widgets/custom_appbar.dart';
import '../../../../auth/presentation/stores/sign_out_store.dart';
import '../../../../cart/presentation/stores/cart_store_module.dart';
import '../../../../product/data/models/product_model.dart';
import '../../../data/models/customer_model.dart';
import '../../../domain/entities/logged_user.dart';
import '../../stores/get_logged_customer_store.dart';

class AccountPage extends StatefulWidget {
  final String title;
  AccountPage({
    Key key,
    this.title = "Customer",
  }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _getCurrentCustomerStore = Modular.get<GetLoggedCustomerStore>();
  final _getCartStore = Modular.get<GetCartStore>();
  final _signOutStore = Modular.get<SignOutStore>();
  TextEditingController _nameController;
  TextEditingController _emailController;

  @override
  void initState() {
    if (LoggedUser.instance.loggedUserUid != null) {
      _getCurrentCustomerStore.execute();
    }
    super.initState();
  }

  _buildTrailingWidget() {
    return Container(
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.red[400],
        onPressed: () async {
          List<ProductModel> cartList = _getCartStore.execute();
          if (cartList.length != 0) {
            cartList?.forEach((item) {
              return item.reference.delete();
            });
          }
          await _signOutStore.executeSignOut();
          Modular.to.pop();
        },
        icon: Icon(Ionicons.ios_log_out, color: Colors.white),
        label: Text(
          'Log Out',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  _buildInputField(
    String title,
    IconData suffixIcon,
    TextEditingController textController, {
    bool isPassword = false,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        style: TextStyle(
            fontFamily: 'SofiaPro',
            color: Colors.red[500],
            fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
              fontFamily: 'Poppins', color: Colors.red[300], fontSize: 12),
          suffixIcon: Icon(suffixIcon),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[200]),
              borderRadius: BorderRadius.circular(30.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[200]),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red[200]),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  _buildAvatarTile(BuildContext context) {
    return Observer(builder: (_) {
      CustomerModel customerModel =
          _getCurrentCustomerStore?.currentCustomer?.data;
      if (_getCurrentCustomerStore.currentCustomer.hasError) {
        return Center(child: Text('Error occured'));
      }
      if (_getCurrentCustomerStore?.currentCustomer?.data == null) {
        return Center(
          child: SpinKitFadingCircle(size: 30.0, color: Colors.red[300]),
        );
      }

      /// return
      return Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius: BorderRadius.circular(75.0),
          border: Border.all(color: Colors.white70, width: 2),
          image: customerModel.avatar != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(customerModel.avatar),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Visibility(
          visible: customerModel?.avatar == null,
          child: Center(
            child: Text(
              (customerModel?.name[0].toUpperCase()) ?? 'C',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      );
    });
  }

  _buildBody(BuildContext context) {
    return Container(
      height: getHeight(context),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(APPLE_WALLPAPER))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
                  child: _buildStack(context)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, getStatusBar(context), 20, 0),
                child: CustomAppBar(
                  backgroundColor: Colors.transparent,
                  showElevation: false,
                  iconData: Ionicons.ios_arrow_round_back,
                  color: Colors.white,
                  onPressed: () {
                    setAllOrientations();
                    Modular.to.pop();
                    setPortraitOrientations();
                  },
                  title: ''.toUpperCase(),
                  trailingWidget: _buildTrailingWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildStack(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return _buildCard();
          },
        ),
        Positioned(
          top: -60,
          left: getDeviceOrientation(context) == Orientation.portrait
              ? getHeight(context) / 5.6
              : getWidth(context) / 2.6,
          child: _buildAvatarTile(context),
        ),
      ],
    );
  }

  _buildCard() {
    return Card(
      color: Colors.white70,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Observer(builder: (_) {
        CustomerModel customerModel =
            _getCurrentCustomerStore?.currentCustomer?.data;
        if (_getCurrentCustomerStore.currentCustomer.hasError) {
          return Center(child: Text('Error occured'));
        }
        if (_getCurrentCustomerStore?.currentCustomer?.data == null) {
          return Center(
            child: SpinKitFadingCircle(
              size: 30.0,
              color: Colors.red[300],
            ),
          );
        }

        _nameController = TextEditingController(text: customerModel.name);
        _emailController = TextEditingController(
            text: customerModel.email ?? 'No Email to display');
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              _buildInputField('Nome', AntDesign.user, _nameController),
              _buildInputField('E-mail', AntDesign.mail, _emailController),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
