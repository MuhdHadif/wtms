import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/User.dart';
import 'package:wtms/model/work.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/util/util.dart';
import 'package:wtms/view/tasksubmitscreen.dart';

class Taskscreen extends StatefulWidget {
  final User user;
  const Taskscreen({super.key, required this.user});

  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  List<Work> workList = <Work>[];

  @override
  void initState(){
    super.initState();
    getworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Tasks", style: TextStyle(color: Colors.white),),
        backgroundColor: Style.themeColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: workList.length,
            itemBuilder: (context, index) => createWorkCard(index)
          ),
        )
      ),
    );
  }

  GestureDetector createWorkCard(int index){
    String statusText;
    Color cardColor;
    bool enabled;
    if (workList[index].status.toString() == "pending"){
      statusText = "${workList[index].status.toString().toCapitalized}, due ${workList[index].dueDate.toString()}";
      cardColor = Colors.white;
      enabled = true;
    } else {
      statusText = workList[index].status.toString().toCapitalized;
      cardColor = Colors.grey.shade300;
      enabled = false;
    }

    return GestureDetector(
      onTap: () async {
        if (enabled){
          await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => Tasksubmitscreen(work: workList[index]))
          );
          getworks();
        }
      },
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/task_icon.png", scale: 7.5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workList[index].title.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      workList[index].description.toString(),
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      statusText,
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

  void getworks() {
    http.post(Uri.parse("${MyConfig.myUrl}wtms/php/get_works.php"), body: {
      "workerId" : widget.user.id
    }).then((response){
      if (response.statusCode == 200){
        log("Response: ${response.body}");
        var jsondata = jsonDecode(response.body);
        if (jsondata["status"] == "success"){
          workList.clear();
          jsondata['data'].forEach((itemdata){
            Work work = Work.fromJson(itemdata);
            log(work.title.toString());
            workList.add(work);
          });
        }
        setState(() {
          
        });
      }
    });
  }
}