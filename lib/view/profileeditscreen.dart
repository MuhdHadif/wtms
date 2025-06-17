import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/User.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/util/util.dart';

class Profileeditscreen extends StatefulWidget {
  final String userId;
  const Profileeditscreen({ super.key, required this.userId });

  @override
  State<Profileeditscreen> createState() => _ProfileeditscreenState();
}

class _ProfileeditscreenState extends State<Profileeditscreen> {
  User user = User();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Style.themeColor
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
                    Util.createTextField("Worker ID", "${user.id}", idController),
                    Util.createFilledInputField("Full name", "${user.fullName}", nameController),
                    Util.createFilledInputField("Email", "${user.email}", emailController),
                    Util.createFilledInputField("Phone number", "${user.phoneNum}", phoneController),
                    Util.createFilledInputField("Address", "${user.address}", addressController, 3),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: Style.outlinedButton,
                        onPressed: (){
                          editprofiledialog();
                        },
                        child: const Text("Confirm edit"),
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

  void editprofiledialog(){
    if (
      nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      phoneController.text.isEmpty ||
      addressController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill out all fields."),
      ));
      return;
    }

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Are you sure you want to edit your profile?"),
          actions: [
            TextButton(
              child: const Text("Confirm edit"),
              onPressed: (){
                Navigator.of(context).pop();
                editprofile();
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

  void editprofile(){
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String address = addressController.text;

    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/edit_profile.php"), body: {
    "submit": "true",
    "workerId": widget.userId,
    "fullName": name,
    "email": email,
    "phoneNum": phone,
    "address": address
    }).then((response) {
      // Success
      log(response.body);
      if (response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if (jsondata["status"] == "success"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Edit successful.")
          ));
          Navigator.of(context).pop();
          return;
        }
      }

      // Fail
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to edit profile, please try again."),
        backgroundColor: Colors.red,
      ));
    });
  }
}