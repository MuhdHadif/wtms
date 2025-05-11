import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/User.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/view/profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtms/view/registrationscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:100, left: 16, right: 16),
                child: Column(
                  children: [
                    Image.asset("assets/images/WTMS_logo.png", scale: 2),
                    Text(
                      "WTMS",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 50
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: Style.inputDecoration.copyWith(
                        labelText: "Email"
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: Style.inputDecoration.copyWith(
                        labelText: "Password",
                      ),
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Text("Remember me"),
                        Checkbox(
                          value: isChecked, 
                          onChanged: (value){
                            setState(() {
                              isChecked = value!;
                            });
                            String email = emailController.text;
                            String password = passwordController.text;
                          
                            if (isChecked){
                              if (email.isEmpty && password.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Please fill in all fields."),
                                  backgroundColor: Colors.red,
                                ));
                                isChecked = false;
                                return;
                              }
                            }
                          }
                        )
                      ],
                    ),
                    SizedBox(
                      width: 400,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          side: BorderSide(width: 0.0, color: const Color.fromARGB(255, 33, 150, 243)),
                        ),
                        onPressed: loginUser,
                        child: const Text("Login"),
                      )
                    )
                  ].map((widget) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: widget,
                  )).toList(),
                ),
              ),
              GestureDetector(onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => RegistrationScreen())
                );
              }, 
              child: Text("Register an account.", style: TextStyle(color: Colors.blue),)),
            ],
          )
        ),
      ),
    );
  }

  void loginUser(){
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all fields."),
      ));
      return;
    }

    storeCredentials(email, password, isChecked);

    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/login_worker.php"), body: {
      "login": "true",
      "email": email,
      "password": password,
    }).then((response) {
      print(response.body);
      if (response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if (jsondata["status"] == "success"){
          var userData = jsondata['data'];
          print("JSON: $userData");
          User user = User.fromJson(userData[0]);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome, ${user.fullName}"),
            backgroundColor: Colors.green,
          ));
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => ProfileScreen(user: user))
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to login.")
          ));
        }
      }
    });
  }
  
  Future<void> storeCredentials(email, password, bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked){
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('remember', isChecked);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('remember');
    }
  }

  Future<void> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    bool? isChecked = prefs.getBool('remember');
    if (email != null && password != null && isChecked != null){
      emailController.text = email;
      passwordController.text = password;
      setState(() {
        this.isChecked = true;
      });
    } else {
      emailController.clear();
      passwordController.clear();
      this.isChecked = false;
    }
  }
}