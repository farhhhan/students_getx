import 'dart:io';

import 'package:flutter/foundation.dart';

class HandleDatasAdding with ChangeNotifier {
  String selectedGender = 'male';
  String department = 'Select Department';
  File? selectedImage;
  DateTime? dob = DateTime.now();

  void setGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setdob(DateTime values) {
    dob = values;
    notifyListeners();
  }

  void setDepartment(String departments) {
    department = departments;
    notifyListeners();
  }

  void imagePickers(File images) {
    selectedImage = images;
    notifyListeners();
  }
}
  