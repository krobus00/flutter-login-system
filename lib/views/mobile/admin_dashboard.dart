import 'package:flutter/material.dart';
import 'package:latihan_request/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  final String username;
  AdminDashboard(this.username);

  @override
  _AdminDashboardState createState() => _AdminDashboardState(this.username);
}

class _AdminDashboardState extends State<AdminDashboard> {
  final String username;
  _AdminDashboardState(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "ADMIN DASHBOARD",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24),
            Text(
              "Hi, $username",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 24),
            RaisedButton(
              onPressed: () async{
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
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new LoginView()));
  }
}
