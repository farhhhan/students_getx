import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:student_db/add_datas.dart';
import 'package:student_db/model/functions.dart';
import 'package:student_db/model/model.dart';

class studentsListingPage extends StatefulWidget {
  const studentsListingPage({super.key});

  @override
  _studentsListingPageState createState() => _studentsListingPageState();
}

class _studentsListingPageState extends State<studentsListingPage> {
  dbhelper dbh = dbhelper();
  TextEditingController searchController = TextEditingController();
  late Box<StudentModel> studentBox = Hive.box(dbname);
  String searchText = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    dbh.getall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("List of Student"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: CupertinoSearchTextField(
              controller: searchController,
              backgroundColor: Colors.grey.withOpacity(0.4),
              prefixInsets: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 3),
              prefixIcon: Icon(CupertinoIcons.search),
              suffixInsets: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 2),
              suffixIcon: Icon(CupertinoIcons.xmark_circle_fill),
              onChanged: (query) {
                onSearchChange(query);
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Studentlist,
              builder:
                  (context, List<StudentModel> studentslists, Widget? child) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: studentslists.length,
                  itemBuilder: (context, index) {
                    final students = studentslists[index];
                    final imagePath = students.image;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                          startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                    backgroundColor: Colors.red,
                                    label: 'Delete',
                                    autoClose: true,
                                    icon: Icons.delete,
                                    onPressed: (context) {
                                      dbh.delete(students.id!);
                                    })
                              ]),
                          endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                    backgroundColor: Colors.green,
                                    label: 'Edit',
                                    // ignore: deprecated_member_use
                                    icon: Icons.edit,
                                    autoClose: true,
                                    onPressed: (context) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Add_Screen(
                                                  isEdit: true,
                                                  id: students.id,
                                                  index: index,
                                                  studentModel: students,
                                                )),
                                      );
                                    })
                              ]),
                          child: ListTile(
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
                          )),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToAddPage();
        },
      ),
    );
  }

  onSearchChange(String value) {
    final studentss = studentBox.values.toList();
    value = searchController.text;
    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(Duration(milliseconds: 500), () {
      if (this.searchText != searchController) {
        final filteredStudents = studentss
            .where((students) =>
                students.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
        Studentlist.value = filteredStudents;
      }
    });
  }

  void _navigateToAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Add_Screen(
                isEdit: false,
              )),
    );
  }
}
