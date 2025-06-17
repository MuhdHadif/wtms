import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/submission.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/util/util.dart';

class Tasksubmiteditscreen extends StatefulWidget {
  final Submission submission;
  const Tasksubmiteditscreen({ super.key, required this.submission });

  @override
  State<Tasksubmiteditscreen> createState() => _TasksubmiteditscreenState();
}

class _TasksubmiteditscreenState extends State<Tasksubmiteditscreen> {
  TextEditingController submissionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    submissionTextController.text = widget.submission.submissionText.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit task submission", style: TextStyle(color: Colors.white),),
        backgroundColor: Style.themeColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("assets/images/submission_icon.png", scale: 6),
                Text(
                  widget.submission.title.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Submitted at\n${widget.submission.submittedAt.toString()}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Util.createInputField("What did you complete?", submissionTextController),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: Style.outlinedButton,
                    onPressed: (){
                      editsubmissiondialog();
                    },
                    child: const Text("Confirm edit"),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void editsubmissiondialog(){
    if (submissionTextController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter submission details."),
      ));
      return;
    }
    editsubmission();
  }

  void editsubmission(){
    String submissionId = widget.submission.id.toString();
    String submissionText = submissionTextController.text;

    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/edit_submission.php"), body: {
      "submit" : "true",
      "submissionId" : submissionId,
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
        content: Text("Edit failed, please try again."),
        backgroundColor: Colors.red,
      ));
    });
  }
}