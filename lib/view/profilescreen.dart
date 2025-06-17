import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtms/model/User.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
// import 'package:wtms/style/style.dart';
import 'package:wtms/util/util.dart';
import 'package:wtms/view/loginscreen.dart';
import 'package:wtms/view/profileeditscreen.dart';
// import 'package:wtms/view/taskscreen.dart';

class ProfileScreen extends StatefulWidget{
  final String userId;
  const ProfileScreen({super.key, required this.userId, });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = User();

  @override
  void initState(){
    super.initState();
    getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Style.themeColor,
        actions: [
          IconButton(onPressed: logoutUser, icon: Icon(Icons.logout), color: Colors.white, highlightColor: Colors.red)
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/worker_icon.png", scale: 3.5),
                    Util.createTextField("Worker ID", "${user.id}", TextEditingController()),
                    Util.createTextField("Full name", "${user.fullName}", TextEditingController()),
                    Util.createTextField("Email", "${user.email}", TextEditingController()),
                    Util.createTextField("Phone number", "${user.phoneNum}", TextEditingController()),
                    Util.createTextField("Address", "${user.address}", TextEditingController(), 3),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: Style.outlinedButton,
                        onPressed: () async {
                          await Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => Profileeditscreen(userId: user.id.toString()))
                          );
                          getprofile();
                        },
                        child: const Text("Edit profile"),
                      )
                    )
                  ].map((widget) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: widget,
                  )).toList(),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  void logoutUser(){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Logout of current account?"),
          actions: [
            TextButton(
              child: const Text("Logout"),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('email');
                await prefs.remove('password');
                await prefs.remove('remember');

                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => LoginScreen())
                );
              }
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              }
            )
          ],
        );
      }
    );
  }

  void getprofile(){
    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/get_profile.php"), body: {
      "workerId" : widget.userId
    }).then((response){
      if (response.statusCode == 200){
        log("Response: ${response.body}");
        var jsondata = jsonDecode(response.body);
        if (jsondata["status"] == "success"){
          setState(() {
            var userData = jsondata['data'];
            user = User.fromJson(userData[0]);
          });
        }
      }
    });
  }
}
