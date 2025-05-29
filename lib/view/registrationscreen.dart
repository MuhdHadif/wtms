import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/view/loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("assets/images/WTMS_logo.png", scale: 2.2),
                Text(
                  "WTMS",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: Style.inputDecoration.copyWith(
                    labelText: "Full name"
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: emailController,
                  decoration: Style.inputDecoration.copyWith(
                    labelText: "Email"
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: passwordController,
                  decoration: Style.inputDecoration.copyWith(
                    labelText: "Password"
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: confirmPasswordController,
                  decoration: Style.inputDecoration.copyWith(
                    labelText: "Confirm Password"
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: phoneController,
                  decoration: Style.inputDecoration.copyWith(
                    labelText: "Phone"
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: addressController,
                  decoration: Style.inputDecoration.copyWith(
                    labelText: "Address"
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                ),
                SizedBox(
                  width: 400,
                  child: OutlinedButton(
                    style: Style.outlinedButton,
                    onPressed: registerUserDialog,
                    child: const Text("Register"),
                  )
                )
              ].map((widget) => Padding(
                padding: const EdgeInsets.all(5),
                child: widget,
              )).toList(),
            ),
          )
        ),
      )
    );
  }

  void registerUserDialog() {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String phone = phoneController.text;
    String address = addressController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all fields"),
      ));
      return;
    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!emailValid){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email is invalid"),
      ));
      return;
    }

    if (password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords do not match."),
      ));
      return;
    }

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Register this account?"),
          content: const Text("Are you sure?"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
                registerUser();
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
  
  void registerUser() {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;
    String address = addressController.text;

    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/register_worker.php"), body: {
    "register": "true",
    "fullName": name,
    "email": email,
    "password": password,
    "phoneNum": phone,
    "address": address
    }).then((response) {
      if (response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if (jsondata["status"] == "success"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Registration successful.")
          ));
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => LoginScreen())
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to register.")
          ));
        }
      }
    });
  }
}