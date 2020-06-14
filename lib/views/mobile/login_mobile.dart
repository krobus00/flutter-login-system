import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latihan_request/pages/regis.dart';
import 'package:latihan_request/services/apiServices.dart';
import 'package:latihan_request/model/login_model.dart';
import 'package:latihan_request/views/mobile/admin_dashboard.dart';
import 'package:latihan_request/views/mobile/member_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMobile extends StatefulWidget {
  // LoginMobile({Key key}) : super(key: key);

  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: height * 0.08),
                    SvgPicture.asset(
                      "assets/img/Group3.svg",
                      width: width * 0.6,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Log in to your account",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 15),
                    buildTextField("username", Icons.person, false, username),
                    SizedBox(height: 15),
                    buildTextField("*********", Icons.lock, true, password),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 30),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(builder: (context) {
                              //     return loginPage();
                              //   }),
                              // );
                            },
                            child: Text(
                              "forgot your password?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    RaisedButton(
                      onPressed: () {
                        ApiServices()
                            .doLogin(username.text, password.text)
                            .then((value) async {
                          Login res = value;
                          Data resData = res.data;
                          if (res.error) {
                            _showMyDialog("ERROR", res.msg);
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('token', resData.token);
                          }
                          if (resData.level == "admin") {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (context) => new AdminDashboard(username.text)));
                          }else if (resData.level == "member") {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (context) => new MemberDashboard(username.text)));
                          }
                        });
                      },
                      padding: EdgeInsets.fromLTRB(60, 17, 60, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.blue,
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return RegisView();
                      }),
                    );
                  },
                  child: Text(
                    "already have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String title, String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  msg,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.blue,
                  child: Text(
                    "Okay",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildTextField(String hint, IconData icon, bool isPassword,
      TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]),
              ),
            ),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.grey,
                ),
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
