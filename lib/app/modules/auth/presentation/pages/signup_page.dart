import 'dart:ui';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../app_controller.dart';
import '../../../../core/data/datasources/local_storage.dart';
import '../../../../core/domain/configs/core_config.dart';
import '../../../../core/domain/consts/img.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../customer/data/models/customer_model.dart';
import '../../../customer/domain/entities/logged_user.dart';
import '../stores/sign_in_with_facebook_store.dart';
import '../stores/sign_in_with_google_store.dart';
import '../stores/sign_up_store.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/on_register_dialog.dart';

class SignUpPage extends StatelessWidget {
  final CustomerModel customerModel = CustomerModel();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppController _controller = Modular.get<AppController>();

  final SignUpStore _signUpStore = Modular.get<SignUpStore>();
  final signInWithGoogleStore = Modular.get<SignInWithGoogleStore>();
  final signInWithFacebookStore = Modular.get<SignInWithFacebookStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
          child: _buildListView(context)),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Image.asset(LOGO_NAMED_WHITE, width: 120, height: 120),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                iconColor: Colors.white,
                icon: Zocial.facebook,
                text: 'Login With Facebook',
                onTap: () async {
                  _controller.select(-2);
                  await signInWithFacebookStore.execute(context);
                  if (LoggedUser.instance.loggedUserUid != null) {
                    EdgeAlert.show(
                      context,
                      title: 'Logged in successfully',
                      description: 'Great! You are logged with Google',
                      gravity: EdgeAlert.TOP,
                      icon: Icons.check,
                      backgroundColor: Colors.green,
                      duration: EdgeAlert.LENGTH_SHORT,
                    );
                    await Modular.to.pushReplacementNamed('/home/city');
                  } else {
                    EdgeAlert.show(
                      context,
                      title: 'Error on Facebook login',
                      description: 'Some error occured on google login',
                      gravity: EdgeAlert.TOP,
                      icon: Icons.info,
                      backgroundColor: Colors.redAccent,
                      duration: EdgeAlert.LENGTH_SHORT,
                    );
                  }
                },
                index: -2,
              ),
              SizedBox(width: 20.0),
              RoundedButton(
                iconColor: Colors.white,
                icon: Zocial.google,
                text: 'Login With Google',
                onTap: () async {
                  _controller.select(-3);
                  await signInWithGoogleStore.execute(context);
                  if (LoggedUser.instance.loggedUserUid != null) {
                    EdgeAlert.show(
                      context,
                      title: 'Logged in successfully',
                      description: 'Greate!! You are logged with Google',
                      gravity: EdgeAlert.TOP,
                      icon: Icons.check,
                      backgroundColor: Colors.green,
                      duration: EdgeAlert.LENGTH_SHORT,
                    );
                    await Modular.to.pushReplacementNamed('/home/city');
                  } else {
                    EdgeAlert.show(
                      context,
                      title: 'Error on Google login',
                      description: 'Some error occured on google login',
                      gravity: EdgeAlert.TOP,
                      icon: Icons.info,
                      backgroundColor: Colors.redAccent,
                      duration: EdgeAlert.LENGTH_SHORT,
                    );
                  }
                },
                index: -3,
              ),
            ],
          ),
          SizedBox(height: 30.0),
          _buildOr(context),
          SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  isName: true,
                  onSaved: (name) {
                    customerModel.name = name;
                  },
                  height: 55.0,
                  fillColor: Colors.white,
                  labelText: 'First Name',
                  filled: true,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: CustomTextField(
                  isSurname: true,
                  onSaved: (surname) {
                    customerModel.surname = surname;
                  },
                  height: 55.0,
                  fillColor: Colors.white,
                  labelText: 'Last Name',
                  filled: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          CustomTextField(
            isMail: true,
            onSaved: (email) {
              customerModel.email = email;
            },
            height: 55.0,
            fillColor: Colors.white,
            labelText: 'E-mail',
            filled: true,
          ),
          SizedBox(height: 10.0),
          CustomTextField(
            obscureText: true,
            controller: _passwordController,
            isPassword: true,
            onSaved: (password) {
              customerModel.password = password;
            },
            height: 55.0,
            fillColor: Colors.white,
            labelText: 'Password',
            filled: true,
          ),
          SizedBox(height: 10.0),
          _buildPassMatcherTextField(
            onSaved: (passwordMatcher) {},
          ),
          SizedBox(height: 15.0),
          _buildOnConfirm(context, onTap: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              LocalStorage.instance.removeData(CUSTOMER);
              LocalStorage.instance.setString(
                CUSTOMER,
                customerModel.name + ' ' + customerModel.surname,
              );
              await _signUpStore.executeSignUp(customerModel, context);
              if (LoggedUser.instance.loggedUserUid != null) {
                showDialog(
                  context: context,
                  builder: (context) => OnRegisterDetailsDialog(
                    title: 'Please confirm your details below',
                    firstName: customerModel.name,
                    lastName: customerModel.surname,
                    email: customerModel.email,
                  ),
                );
              }
            }
          }),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _buildPassMatcherTextField({FormFieldSetter<String> onSaved}) {
    return FormField<String>(
      initialValue: '',
      onSaved: onSaved,
      validator: (value) {
        if (value.isEmpty) {
          return "*field shouldn't be empty";
        }
        if (_passwordController.text != value) return "*password doesn't match";

        return null;
      },
      builder: (FormFieldState<String> state) => Container(
        child: Column(
          children: [
            Container(
              height: 55.0,
              child: TextField(
                obscureText: true,
                onChanged: (value) => state.didChange(value),
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Confirm Password',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle:
                        TextStyle(color: Colors.black26, fontSize: 15.0)),
              ),
            ),
            // getting error message
            (state.hasError)
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(state.errorText,
                        style: TextStyle(color: Colors.amber, fontSize: 12)))
                : Container(width: 0.0, height: 0.0),
          ],
        ),
      ),
    );
  }

  Container _buildOnConfirm(BuildContext context, {VoidCallback onTap}) {
    return Container(
      alignment: Alignment.centerRight,
      child: RoundedButton(
        icon: FontAwesomeIcons.check,
        text: 'Confirm',
        isGreenColor: true,
        onTap: onTap,
      ),
    );
  }

  Row _buildOr(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
                width: getWidth(context), height: 1, color: Colors.white)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Login With Email And Password',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        Expanded(
            child: Container(
                width: getWidth(context), height: 1, color: Colors.white))
      ],
    );
  }
}
