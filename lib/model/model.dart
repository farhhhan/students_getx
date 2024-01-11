import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String rollNo;

  @HiveField(2)
  String? image;

  @HiveField(3)
  int? id;

  @HiveField(4)
  String? department;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  String? number;

  @HiveField(7)
  String? dob;

  StudentModel({
    required this.name,
    required this.image,
    required this.rollNo,
    required this.dob,
    required this.department,
    required this.gender,
    this.id,
    required this.number,
  });
}
