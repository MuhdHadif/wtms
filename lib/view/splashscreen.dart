import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/User.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/view/loginscreen.dart';
import 'package:wtms/view/profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    loadUserCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/WTMS_logo.png", scale: 2),
              Text(
                "WORKER TASK MANAGEMENT SYSTEM",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.blue)
                ),
              )
            ]
          ),
        ),
      )
    );
  }
  
  Future<void> loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    bool isChecked = (prefs.getBool('remember')) ?? false;
    print("loadCredentials");

    if (isChecked){
      http.post(Uri.parse("${MyConfig.myUrl}wtms/php/login_worker.php"), body: {
      "login": "true",
      "email": email,
      "password": password,
      }).then((response) {
        if (response.statusCode == 200){
          var jsondata = json.decode(response.body);
          if (jsondata["status"] == "success"){
            var userData = jsondata['data'];
            User user = User.fromJson(userData[0]);
            print(user.fullName);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Welcome, ${user.fullName}"),
              backgroundColor: Colors.green,
            ));
            
            toProfileScreen(user);
          } else {
            User user = User(
              id: '0',
              fullName: 'Guest',
              email: '',
              password: '',
              phoneNum: '',
              address: '',
            );
            
            toLoginScreen(user);
          }
        }
      });
    } else {
      User user = User(
        id: '0',
        fullName: 'Guest',
        email: '',
        password: '',
        phoneNum: '',
        address: '',
      );
      
      toLoginScreen(user);
    }
  }

  void toLoginScreen(User user){
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  void toProfileScreen(User user){
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => ProfileScreen(user: user)));
    });
  }
}
