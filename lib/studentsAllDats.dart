import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:student_db/Provider.dart/genderProvider.dart';
import 'package:student_db/model/externalDatas.dart';
import 'package:student_db/model/functions.dart';
import 'package:student_db/model/model.dart';
import 'package:student_db/studentDetial.dart';

class DepartmentCategory extends StatefulWidget {
  const DepartmentCategory({super.key});

  @override
  _studentsListingPageState createState() => _studentsListingPageState();
}

class _studentsListingPageState extends State<DepartmentCategory> {
  TextEditingController searchController = TextEditingController();
  dbhelper dbh = dbhelper();
  late Box<StudentModel> studentBox = Hive.box(dbname);

  @override
  void initState() {
    super.initState();
    dbh.getall();
  }

  @override
  Widget build(BuildContext context) {
    final handleData = Provider.of<HandleDatasAdding>(context, listen: false);
    handleData.department = 'Select Department';

    void filterStudentsByDepartment(String department) {
      final studentss = studentBox.values.toList();
      final filteredstudentss = studentss
          .where((students) => students.department == department)
          .toList();
      Studentlist.value = filteredstudentss;
      if (department == "Select Department") {
        Studentlist.value = studentss;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Search Student Department"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Consumer<HandleDatasAdding>(
              builder: (context, values, child) {
                return DropdownButtonFormField<String>(
                  value: values.department,
                  decoration: const InputDecoration(
                    fillColor: Color(0xABFFFEFE),
                    labelText: 'Department',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    handleData.setDepartment(value!);
                    filterStudentsByDepartment(value);
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        handleData.department == 'Select Department') {
                      return 'Please select a department';
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Studentlist,
              builder:
                  (context, List<StudentModel> studentslists, Widget? child) {
                if (studentslists.isEmpty) {
                  return Center(
                    child: Text('No Data'),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: studentslists.length,
                  itemBuilder: (context, index) {
                    final students = studentslists[index];
                    final imagePath = students.image;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetials(
                                studentModel: students,
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: FileImage(File(imagePath!)),
                        ),
                        title: Text(
                          "${studentslists[index].name}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(studentslists[index].department!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
