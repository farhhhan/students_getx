import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_db/model/model.dart';

String dbname = 'dbname';
ValueNotifier<List<StudentModel>> Studentlist = ValueNotifier([]);

class dbhelper{
  Future<void> delete(int id) async {
    final remove = await Hive.openBox<StudentModel>(dbname);
    remove.delete(id);
    getall();
  }

  Future<void> save(StudentModel value) async {
    final save = await Hive.openBox<StudentModel>(dbname);
    final id = await save.add(value);
    final data = save.get(id);
    await save.put(
      id,
      StudentModel(
        number: data!.number,
        name: data.name,
        rollNo: data.rollNo,
        department: data.department,
        dob: data.dob,
        gender: data.gender,
        image: data.image,
        id: id,
      ),
    );
    Studentlist.value.addAll(save.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    Studentlist.notifyListeners();
    print(Studentlist);
  }

  Future<void> getall() async {
    final save = await Hive.openBox<StudentModel>(dbname);
    Studentlist.value.clear();
    Studentlist.value.addAll(save.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    Studentlist.notifyListeners();
  }
}
