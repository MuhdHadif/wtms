import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtms/model/User.dart';
import 'package:wtms/style/style.dart';
// import 'package:wtms/style/style.dart';
import 'package:wtms/util/util.dart';
import 'package:wtms/view/loginscreen.dart';
// import 'package:wtms/view/taskscreen.dart';

class ProfileScreen extends StatefulWidget{
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen", style: TextStyle(color: Colors.white),),
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
                    Util.createTextField("Worker ID", "${widget.user.id}", idController),
                    Util.createTextField("Full name", "${widget.user.fullName}", nameController),
                    Util.createTextField("Email", "${widget.user.email}", emailController),
                    Util.createTextField("Phone number", "${widget.user.phoneNum}", phoneController),
                    Util.createTextField("Address", "${widget.user.address}", addressController, 3),
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
}
