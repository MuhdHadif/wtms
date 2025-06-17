import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/User.dart';
import 'package:wtms/model/submission.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/view/tasksubmiteditscreen.dart';
// import 'package:wtms/view/tasksubmitscreen.dart';

class Taskhistoryscreen extends StatefulWidget {
  final User user;
  const Taskhistoryscreen({ super.key, required this.user });

  @override
  State<Taskhistoryscreen> createState() => _TaskhistoryscreenState();
}

class _TaskhistoryscreenState extends State<Taskhistoryscreen> {
  List<Submission> submissionList = <Submission>[];

  @override
  void initState(){
    super.initState();
    getsubmissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submitted tasks", style: TextStyle(color: Colors.white),),
        backgroundColor: Style.themeColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: submissionList.length,
            itemBuilder: (context, index) => createWorkCard(index)
          ),
        )
      ),
    );
  }

  GestureDetector createWorkCard(int index){

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Tasksubmiteditscreen(submission: submissionList[index]))
        );
        getsubmissions();
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/submission_icon.png", scale: 7.5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submissionList[index].title.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\"${submissionList[index].submissionText.toString()}\"",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Submitted at\n${submissionList[index].submittedAt.toString()}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 8),
                child: Image.asset("assets/images/chevron_right_icon.png", scale: 2),
              ),
            ]
          ),
        ),
      ),
    );
  }

  void getsubmissions() {
    log("getsubmissions");
    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/get_submissions.php"), body: {
      "workerId" : widget.user.id
    }).then((response){
      if (response.statusCode == 200){
        log("Response: ${response.body}");
        var jsondata = jsonDecode(response.body);
        if (jsondata["status"] == "success"){
          submissionList.clear();
          jsondata['data'].forEach((itemdata){
            Submission s = Submission.fromJson(itemdata);
            log(s.title.toString());
            submissionList.add(s);
          });
        }
        setState(() {
          
        });
      }
    });
  }
}