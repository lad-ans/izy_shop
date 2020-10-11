import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../app_controller.dart';
import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/entities/route_entity.dart';
import '../../../../core/domain/utils/number_formatter.dart';
import '../../../../core/presentation/widgets/amount_checkout_row.dart';
import '../../../../core/presentation/widgets/custom_statusbar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/shopping_appbar.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../../data/datasources/delivery_time.dart';
import '../../data/datasources/payment_method.dart';
import '../../data/models/order_model.dart';
import '../stores/set_delivery_time_store.dart';
import '../stores/set_order_store.dart';
import '../widgets/checkout_dialog.dart';

class CheckoutPage extends StatefulWidget {
  final RouteEntity routeEntity;

  const CheckoutPage({Key key, this.routeEntity}) : super(key: key);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppController _controller = Modular.get<AppController>();
  final setOrderStore = Modular.get<SetOrderStore>();
  OrderModel orderModel = OrderModel();

  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Container(
        height: getHeight(context),
        child: Stack(
          children: [
            SizedBox(height: getStatusBar(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 75 + getStatusBar(context)),
                    AmountCheckoutRow(
                      title: 'Total Amount',
                      amount: NumberFormatter.instance
                          .numToString(widget.routeEntity.totalAmount),
                    ),
                    Divider(),
                    Text('Select Payment', style: TextStyle(fontSize: 18.0)),
                    _buildPaymentMethodList(
                      onSaved: (paymentMethod) {
                        orderModel.paymentMethod = paymentMethod;
                      },
                    ),
                    Divider(),
                    Text('Delivery Location', style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 20),
                    _buildAddress(
                      onSaved: (address) {
                        orderModel.location = address;
                      },
                      onRoadSaved: (road) {
                        orderModel.road = road;
                      },
                      onHouseNoSaved: (houseNo) {
                        orderModel.houseNo = 'House No. ' + houseNo;
                      },
                    ),
                    Divider(),
                    Text('Contacts', style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 20),
                    _buildContact(onSaved: (contact) {
                      orderModel.onDeliveryPhone = '+258' + contact;
                    }),
                    Divider(),
                    Text('Delivery Time', style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 20),
                    _buildDeliveryTime(
                      onSaved: (deliveryTime) {
                        if (Modular.get<SetDeliveryTimeStore>().deliveryTime ==
                            null) {
                          if (deliveryTime) {
                            orderModel.deliveryTime = DT_30MIN_1HOUR;
                          } else {
                            orderModel.deliveryTime = DT_2HOUR_3HOUR;
                          }
                        } else {
                          orderModel.deliveryTime =
                              Modular.get<SetDeliveryTimeStore>().deliveryTime;
                        }
                      },
                    ),
                    Divider(),
                    Text('Any special instruction for delivery?',
                        style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 20),
                    _buildDeliveryInstructionTextField(
                      onSaved: (instruction) {
                        orderModel.instruction = instruction;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      alignment: Alignment.centerRight,
                      child: RoundedButton(
                        isGreenColor: true,
                        icon: Icons.check,
                        iconSize: 35.0,
                        text: 'Confirm',
                        btnWidth: 70.0,
                        btnHeight: 70.0,
                        width: 70.0,
                        textColor: Colors.black87,
                        textSize: 14.0,
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            orderModel.products = widget.routeEntity.cartList;
                            orderModel.amount = widget.routeEntity.totalAmount;
                            orderModel.customerName =
                                LoggedUser.instance.loggedUsername;
                            _formKey.currentState.save();
                            await setOrderStore.execute(orderModel);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CheckoutDialog(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomStatusBar(color: Colors.white),
            Padding(
              padding: EdgeInsets.only(top: getStatusBar(context)),
              child: ShoppingAppBar(
                onNavigate: true,
                routeEntity: widget.routeEntity,
                fullAppBar: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInstructionTextField({
    FormFieldSetter<String> onSaved,
  }) {
    return FormField<String>(
      initialValue: '',
      onSaved: onSaved,
      builder: (FormFieldState<String> state) {
        return TextField(
          onChanged: (value) => state.didChange(value),
          decoration: InputDecoration(
            labelText: 'Ex: Ring the outside bell when arrive...',
            alignLabelWithHint: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            fillColor: Colors.black12,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.black12, width: 0.6)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.black12, width: 0.6)),
          ),
          maxLines: 3,
        );
      },
    );
  }

  DatePickerTheme get pickerTheme => DatePickerTheme(
      headerColor: Colors.red[300],
      backgroundColor: Colors.white70,
      cancelStyle: TextStyle(color: Colors.white, fontSize: 16),
      itemStyle: TextStyle(color: Colors.red[300], fontSize: 18),
      doneStyle: TextStyle(color: Colors.white, fontSize: 16));

  _buildDeliveryTime({FormFieldSetter<bool> onSaved}) {
    String customTime;
    return Row(
      children: [
        RoundedButton(
          color: Colors.black12,
          borderColor: Colors.black87,
          icon: Icons.timer,
          text: 'Choose\nTime',
          textColor: Colors.black,
          textSize: 13.0,
          btnWidth: 70.0,
          btnHeight: 70.0,
          width: 70.0,
          iconSize: 35,
          onTap: () async {
            _controller.select(15);

            /// pick date
            await DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime.now(),
              maxTime: DateTime(2021, 12, 31),
              theme: pickerTheme,
              onConfirm: (date) {
                var selectedDate = '${date.day}/${date.month}/${date.year}';

                /// pick time
                DatePicker.showTimePicker(context,
                    theme: pickerTheme,
                    showTitleActions: true, onConfirm: (date) {
                  customTime =
                      'Date: $selectedDate \nHours: ${date.hour}h:${date.minute}min';
                  Modular.get<SetDeliveryTimeStore>()
                      .setDeliveryTime(customTime);
                }, currentTime: DateTime.now());
              },
              currentTime: DateTime.now(),
              locale: LocaleType.en,
            );
            _controller.select(1200);
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: FormField<bool>(
              initialValue: false,
              onSaved: onSaved,
              builder: (state) {
                return Observer(builder: (_) {
                  final String deliveryTime =
                      Modular.get<SetDeliveryTimeStore>().deliveryTime;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: deliveryTime == null,
                            child: Text('2h - 3h',
                                style: TextStyle(color: Colors.red[300])),
                          ),
                          Visibility(
                            visible: deliveryTime == null,
                            child: Switch(
                              activeColor: Colors.green[200],
                              value: state.value,
                              onChanged: (value) {
                                state.didChange(value);
                              },
                            ),
                          ),
                          Visibility(
                            visible: deliveryTime == null,
                            child: Text('30min - 1h',
                                style: TextStyle(color: Colors.red[300])),
                          ),
                        ],
                      ),
                      Text(
                        deliveryTime ?? '',
                        style: TextStyle(
                          color: Colors.red[300],
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildContact({FormFieldSetter<String> onSaved}) {
    return Row(
      children: [
        RoundedButton(
          color: Colors.black12,
          borderColor: Colors.black87,
          icon: Ionicons.ios_phone_portrait,
          text: 'New\nContact',
          textColor: Colors.black,
          textSize: 13.0,
          btnWidth: 70.0,
          btnHeight: 70.0,
          width: 70.0,
          iconSize: 35,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormField<String>(
              initialValue: '',
              onSaved: onSaved,
              validator: (value) {
                if (value.trim().isEmpty) return '*required field';
                if (value.trim().length < 4) return '*Address too short';
                return null;
              },
              builder: (FormFieldState<String> state) {
                return Column(
                  children: [
                    TextField(
                      onChanged: (value) => state.didChange(value),
                      decoration: InputDecoration(
                          prefix: Text('+258 ',
                              style: TextStyle(color: Colors.red[300])),
                          labelText: '(+258) 84 123 45 67',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric()),
                    ),
                    // getting error message
                    (state.hasError)
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(state.errorText,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12)))
                        : Container(width: 0.0, height: 0.0),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildAddress({
    FormFieldSetter<String> onSaved,
    FormFieldSetter<String> onRoadSaved,
    FormFieldSetter<String> onHouseNoSaved,
  }) {
    return Row(
      children: [
        RoundedButton(
          color: Colors.black12,
          borderColor: Colors.black87,
          icon: Icons.location_on,
          text: 'New\nAddress',
          textColor: Colors.black,
          textSize: 13.0,
          btnWidth: 70.0,
          btnHeight: 70.0,
          width: 70.0,
          iconSize: 35,
          onTap: () async {
            _controller.select(14);
            await Modular.to.pushNamed(
              '/checkout/maps',
              arguments: RouteEntity(
                  addressController: addressController, orderModel: orderModel),
            );
            _controller.select(1100);
          },
          index: 14,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              TextFormField(
                // enabled: false,
                controller: addressController,
                onChanged: (value) {},
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Sommerschild, Maputo',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(),
                ),
                onSaved: onSaved,
                validator: (value) {
                  if (value.trim().isEmpty) return '*required field';
                  if (value.trim().length < 3) return '*Address too short';
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Road',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(),
                ),
                onSaved: onRoadSaved,
              ),
              TextFormField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixText: 'House no. ',
                  labelText: 'House no.',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(),
                ),
                onSaved: onHouseNoSaved,
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildPaymentMethodList({
    FormFieldSetter<String> onSaved,
  }) {
    return FormField<String>(
      onSaved: onSaved,
      initialValue: '',
      validator: (value) {
        if (value.isEmpty) return '*no payment method selected';
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          children: [
            Container(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RoundedButton(
                    color: Colors.black12,
                    borderColor: Colors.black87,
                    icon: FontAwesomeIcons.moneyBillAlt,
                    text: 'Cash\n(on delivery)',
                    textColor: Colors.black,
                    textSize: 13.0,
                    btnWidth: 70.0,
                    btnHeight: 70.0,
                    width: 70.0,
                    iconSize: 35,
                    isCustomized: true,
                    onTap: () async {
                      _controller.select(4);
                      state.didChange(PaymentMethod.CASH_ON_DELIVERY);
                    },
                    paymentMethod: PaymentMethod.CASH_ON_DELIVERY,
                    index: 4,
                  ),
                  RoundedButton(
                    iconColor: Colors.black12,
                    color: Colors.black12,
                    borderColor: Colors.black12,
                    icon: Ionicons.ios_card,
                    text: 'Pay\nOnline',
                    textColor: Colors.black,
                    textSize: 13.0,
                    btnWidth: 70.0,
                    btnHeight: 70.0,
                    width: 70.0,
                    iconSize: 35,
                    isCustomized: true,
                    onTap: null,
                    isNull: true,
                    // onTap: () async {
                    // _controller.select(0);
                    // },
                    // index: 0,
                  ),
                  SizedBox(width: 7.0),
                  RoundedButton(
                    color: Colors.black12,
                    borderColor: Colors.black87,
                    icon: Icons.monetization_on,
                    text: 'Bank\nTransfer',
                    textColor: Colors.black,
                    textSize: 13.0,
                    btnWidth: 70.0,
                    btnHeight: 70.0,
                    width: 70.0,
                    iconSize: 35,
                    isCustomized: true,
                    onTap: () async {
                      _controller.select(1);
                      state.didChange(PaymentMethod.BANK_TRANSFER);
                    },
                    paymentMethod: PaymentMethod.BANK_TRANSFER,
                    index: 1,
                  ),
                  SizedBox(width: 7.0),
                  RoundedButton(
                    iconColor: Colors.black12,
                    color: Colors.black12,
                    borderColor: Colors.black12,
                    icon: Icons.phone_android,
                    text: 'Payment of\nServices',
                    textColor: Colors.black,
                    textSize: 13.0,
                    btnWidth: 70.0,
                    btnHeight: 70.0,
                    width: 70.0,
                    iconSize: 35,
                    isCustomized: true,
                    onTap: null,
                    isNull: true,
                    // onTap: () async {
                    // _controller.select(2);
                    // print(PaymentMethod.PAYMENT_OF_SERVICES);
                    // },
                    // index: 2,
                  ),
                  SizedBox(width: 7.0),
                  RoundedButton(
                    iconColor: Colors.black12,
                    color: Colors.black12,
                    borderColor: Colors.black12,
                    icon: Icons.mobile_screen_share,
                    text: 'POS\n',
                    textColor: Colors.black,
                    textSize: 13.0,
                    btnWidth: 70.0,
                    btnHeight: 70.0,
                    width: 70.0,
                    iconSize: 35,
                    isCustomized: true,
                    onTap: null,
                    isNull: true,
                    // onTap: () async {
                    // _controller.select(3);
                    // print(PaymentMethod.POS);
                    // },
                    // index: 3,
                  ),
                  SizedBox(width: 7.0),
                ],
              ),
            ),
            // getting error message
            (state.hasError)
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(state.errorText,
                        style: TextStyle(color: Colors.red, fontSize: 12)))
                : Container(width: 0.0, height: 0.0),
          ],
        );
      },
    );
  }
}
