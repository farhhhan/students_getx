import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_db/model/functions.dart';
import 'package:student_db/model/model.dart';
import 'package:student_db/studentDetial.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dbhelper dbh = dbhelper();
  late Box<StudentModel> studentBox = Hive.box(dbname);
  TextEditingController searchController = TextEditingController();
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
        title: Text("Search Student Here"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: CupertinoSearchTextField(
              controller: searchController,
              placeholder: 'Search',
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
              builder: (context, List<StudentModel> studentslists, _) {
                if (studentslists.isEmpty) {
                  return Center(child: Text("No Data"));
                } else {
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  onSearchChange(String value) {
    final studentss = studentBox.values.toList();
    value = searchController.text;
    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(Duration(milliseconds: 250), () {
      if (this.searchText != searchController) {
        final filteredStudents = studentss
            .where((students) =>
                students.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
        Studentlist.value = filteredStudents;
      }
    });
  }
}
