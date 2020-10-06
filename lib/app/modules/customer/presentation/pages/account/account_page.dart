import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/domain/configs/core_config.dart';
import '../../../../../core/domain/consts/img.dart';
import '../../../../../core/presentation/widgets/custom_appbar.dart';
import '../../../../auth/presentation/stores/sign_out_store.dart';
import '../../../../cart/presentation/stores/get_customer_cart_store.dart';
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
  final getCurrentCustomerStore = Modular.get<GetLoggedCustomerStore>();
  final getCustomerCartStore = Modular.get<GetCustomerCartStore>();
  final signOutStore = Modular.get<SignOutStore>();
  TextEditingController _nameController;
  // TextEditingController _surnameController;
  TextEditingController _emailController;

  @override
  void initState() {
    if (LoggedUser.instance.loggedUserUid != null) {
      getCurrentCustomerStore.execute(LoggedUser.instance.loggedUserUid);
      getCustomerCartStore?.execute(LoggedUser.instance.loggedUserUid);
    }
    super.initState();
  }

  Widget _buildTrailingWidget() {
    return Container(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.red[400],
        onPressed: () async {
          List<ProductModel> cartList = getCustomerCartStore.cartList.data;
          cartList?.forEach((item) {
            return item.reference.delete();
          });
          await signOutStore.executeSignIn();
          Modular.to.pop();
        },
        child: Text(
          'Sair',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
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
          getCurrentCustomerStore?.currentCustomer?.data;
      if (getCurrentCustomerStore.currentCustomer.hasError) {
        return Center(child: Text('Error occured'));
      }
      if (getCurrentCustomerStore?.currentCustomer?.data == null) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red[300]),
          ),
        );
      }
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
              (customerModel?.name[0].toUpperCase() +
                      (customerModel.surname.isNotEmpty
                          ? customerModel?.surname[0]?.toUpperCase()
                          : '')) ??
                  'C',
              style: TextStyle(
                fontFamily: 'Sans',
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBody(BuildContext context) {
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
                  onPressed: () => Modular.to.pop(),
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

  Stack _buildStack(BuildContext context) {
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

  Card _buildCard() {
    return Card(
      color: Colors.white70,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Observer(builder: (_) {
        CustomerModel customerModel =
            getCurrentCustomerStore?.currentCustomer?.data;
        if (getCurrentCustomerStore.currentCustomer.hasError) {
          return Center(child: Text('Error occured'));
        }
        if (getCurrentCustomerStore?.currentCustomer?.data == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red[300]),
            ),
          );
        }

        _nameController = TextEditingController(
            text: customerModel.name + ' ' + customerModel.surname);
        // _surnameController = TextEditingController(
        //     text: customerModel.surname);
        _emailController = TextEditingController(
            text: customerModel.email ?? 'customer@izyshop.co.mz');
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              _buildInputField('Nome', AntDesign.user, _nameController),
              // _buildInputField(
              //     'Apelido', SimpleLineIcons.user, _surnameController),
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
