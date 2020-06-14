import 'package:flutter/material.dart';
import 'package:latihan_request/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberDashboard extends StatefulWidget {
  final String username;
  MemberDashboard(this.username);

  @override
  _MemberDashboardState createState() => _MemberDashboardState(this.username);
}

class _MemberDashboardState extends State<MemberDashboard> {
  final String username;
  _MemberDashboardState(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "MEMBER DASHBOARD",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24),
            Text(
              "Hi, $username",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 24),
            RaisedButton(
              onPressed: () async {
                await logout();
              },
              padding: EdgeInsets.fromLTRB(60, 17, 60, 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.blueAccent,
              child: Text(
                "LOGOUT",
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
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("token");
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new LoginView()));
  }
}
