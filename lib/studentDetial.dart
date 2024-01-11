import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_db/model/model.dart';

// ignore: must_be_immutable
class StudentDetials extends StatelessWidget {
  StudentDetials({super.key, required this.studentModel});
  StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://th.bing.com/th/id/OIP.X1jXEJGWDvsEdLTatNZNpwHaEc?w=312&h=187&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                    fit: BoxFit.fill),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40))),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ))
                  ],
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                CircleAvatar(
                  maxRadius: 70,
                  backgroundImage: FileImage(File(studentModel.image!)),
                ),
                Text(
                  "${studentModel.name}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 18,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 13),
                      child: Text(
                        "Genaral",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      title: Text("Department:"),
                      subtitle: Text("${studentModel.department}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Age:"),
                      subtitle: Text(
                          "${DateTime.now().year - DateTime.parse(studentModel.dob!).year}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Date of Birth:"),
                      subtitle: Text(
                          "${DateFormat("dd/M/yyyy").format(DateTime.parse(studentModel.dob!))}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Gender:"),
                      subtitle: Text("${studentModel.gender}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Roll Number :"),
                      subtitle: Text("${studentModel.rollNo}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Phone Number:"),
                      subtitle: Text("${studentModel.number}"),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
