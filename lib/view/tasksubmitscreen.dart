import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/User.dart';
import 'package:wtms/model/work.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/util/util.dart';

class Tasksubmitscreen extends StatefulWidget {
  final Work work;
  const Tasksubmitscreen({super.key, required this.work});

  @override
  State<Tasksubmitscreen> createState() => _TasksubmitscreenState();
}

class _TasksubmitscreenState extends State<Tasksubmitscreen> {
  TextEditingController submissionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Task Completion", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("assets/images/task_icon.png", scale: 6),
                Text(
                  widget.work.title.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.work.description.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Util.createTextField("Title", widget.work.title.toString(), TextEditingController()),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Util.createInputField("What did you complete?", submissionTextController),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: Style.outlinedButton,
                    onPressed: (){
                      submitworkdialog();
                    },
                    child: const Text("Submit task"),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void submitworkdialog(){
    if (submissionTextController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter submission details."),
      ));
      return;
    }
    submitwork();
  }

  void submitwork(){
    String workId = widget.work.id.toString();
    String workerId = widget.work.assignedTo.toString();
    String submissionText = submissionTextController.text;

    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/submit_work.php"), body: {
      "submit" : "true",
      "workId" : workId,
      "workerId" : workerId,
      "submissionText" : submissionText
    }).then((response){
      // Success
      if (response.statusCode == 200){
        log("Response: ${response.body}");
        var jsondata = jsonDecode(response.body);
        if (jsondata["status"] == "success"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Submission success."),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          return;
        } 
      }

      // Fail
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Submission failed, please try again."),
        backgroundColor: Colors.red,
      ));
    });
  }
}