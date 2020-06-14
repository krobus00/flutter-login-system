import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:latihan_request/views/mobile/login_mobile.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LoginMobile(),
      // desktop: LoginDesktop(),
    );
  }
}