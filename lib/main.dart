import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latihan_request/pages/login.dart';
import 'package:latihan_request/views/mobile/member_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latihan_request/services/apiServices.dart';
import 'package:latihan_request/model/info_model.dart';
import 'package:latihan_request/views/mobile/admin_dashboard.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);
    if (token == null) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginView()));
    } else {
      ApiServices().getInfo(token).then((value) {
        Info res = value;
        DataInfo resData = res.data;
        if (resData.level == "admin") {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => new AdminDashboard(resData.username)));
        } else if (resData.level == "member") {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => new MemberDashboard(resData.username)));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(seconds: 2), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: width),
          Text(
            "APP NAME",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24),
          SvgPicture.asset(
            "assets/img/Group3.svg",
            width: width * 0.9,
          ),
        ],
      ),
    );
  }
}
