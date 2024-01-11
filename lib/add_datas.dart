import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_db/Provider.dart/genderProvider.dart';
import 'package:student_db/model/externalDatas.dart';
import 'package:student_db/model/functions.dart';
import 'package:student_db/model/model.dart';

// ignore: must_be_immutable
class Add_Screen extends StatelessWidget {
  Add_Screen(
      {this.id, this.index, this.studentModel, required this.isEdit, Key? key});
  final StudentModel? studentModel;
  final int? id;
  final int? index;
  bool isEdit;

  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  dbhelper db = dbhelper();
  final _formKey = GlobalKey<FormState>();

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);
  bool isAge(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{2}[)]?$').hasMatch(input);

  @override
  Widget build(BuildContext context) {
    final handleData = Provider.of<HandleDatasAdding>(context, listen: false);
    handleData.selectedImage = null;
    if (isEdit) {
      nameController.text = studentModel!.name;
      rollController.text = studentModel!.rollNo;
      phoneController.text = studentModel!.number!;

      handleData.department = studentModel!.department!;
      handleData.selectedGender = studentModel!.gender!;
      handleData.selectedImage = File(studentModel!.image!);
      handleData.dob = DateTime.parse(studentModel!.dob!);
    }
    void showDatePickers() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990),
              lastDate: DateTime(2050))
          .then((value) {
        handleData.setdob(value!);
      });
    }

    print("BUILD");

    return Consumer(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Student"),
          ),
          body: ListView(children: [
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Student Name..',
                          label: Text('Name'),
                          fillColor: Colors.blue.withOpacity(.9)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: rollController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.abc),
                          hintText: 'Enter Student Roll Number..',
                          label: Text('Student Roll Number'),
                          fillColor: Colors.blue.withOpacity(.9)),
                      validator: (value) {
                        if (!isAge(value!)) {
                          return 'Please enter a student age';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mobile_friendly),
                          hintText: 'Enter Student Mobile Number..',
                          label: Text('Mobile Number'),
                          fillColor: Colors.blue.withOpacity(.9)),
                      validator: (value) {
                        if (!isPhone(value!)) {
                          return 'Please enter a mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please let us know your Date of Birth:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150,
                      child: Row(
                        children: [
                          Consumer<HandleDatasAdding>(
                            builder: (context, value, child) {
                              return TextButton.icon(
                                  onPressed: () {
                                    showDatePickers();
                                    print((DateTime.now().year) -
                                        (handleData.dob!.year));
                                  },
                                  icon: Icon(Icons.date_range),
                                  label: Text(
                                      "${DateFormat("dd/M/yyyy").format(DateTime.parse(handleData.dob.toString()))}"));
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please let us know your gender:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Consumer<HandleDatasAdding>(
                      builder: (context, value, child) {
                        return ListTile(
                          leading: Radio<String>(
                            value: 'male',
                            groupValue: value.selectedGender,
                            onChanged: (value) {
                              handleData.setGender(value!);
                            },
                          ),
                          title: const Text('Male'),
                        );
                      },
                    ),
                    Consumer<HandleDatasAdding>(
                      builder: (context, value, child) {
                        return ListTile(
                          leading: Radio<String>(
                            value: 'female',
                            groupValue: value.selectedGender,
                            onChanged: (value) {
                              handleData.setGender(value!);
                            },
                          ),
                          title: const Text('Female'),
                        );
                      },
                    ),
                    Text(
                      'Please let us know your Department:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<HandleDatasAdding>(
                      builder: (context, values, child) {
                        return DropdownButtonFormField<String>(
                          value: values.department,
                          decoration: const InputDecoration(
                            fillColor: Color(0xABFFFEFE),
                            labelText: 'product category',
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
                            values.setDepartment(value!);
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
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Please let us know your Profile:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<HandleDatasAdding>(
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () async {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            File pickedImageFile = File(image!.path);
                            if (image != null) {
                              handleData.imagePickers(pickedImageFile);
                            }
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: handleData.selectedImage != null
                                ? Image.file(
                                    handleData.selectedImage!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.add_photo_alternate,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate() &&
                                handleData.selectedImage != null) {
                              _formKey.currentState!.save();
                              if (isEdit) {
                                studentModel!.image =
                                    handleData.selectedImage!.path;
                                studentModel!.name = nameController.text;
                                studentModel!.rollNo = rollController.text;
                                studentModel!.number = phoneController.text;
                                studentModel!.department =
                                    handleData.department;
                                studentModel!.id = id;
                                studentModel!.gender =
                                    handleData.selectedGender;
                                studentModel!.dob = handleData.dob.toString();
                                final updateBox =
                                    await Hive.openBox<StudentModel>(dbname);

                                // Update the product in Hive
                                await updateBox.put(id, studentModel!);
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                Studentlist.notifyListeners();
                                handleData.selectedImage = null;
                                handleData.dob = DateTime.now();
                                Navigator.pop(context);
                              } else {
                                addStudent(handleData.selectedGender,
                                    depart: handleData.department,
                                    imagepath: handleData.selectedImage!.path,
                                    dob: handleData.dob.toString());
                                showMySnackbar(
                                    context, "Data Added Succesfully");
                                rollController.text = '';
                                phoneController.text = '';
                                nameController.text = '';
                                handleData.selectedImage = null;
                                handleData.dob = DateTime.now();
                              }
                            } else {
                              showMySnackbar(context, "Please Fill All Datas");
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                (isEdit) ? "Update" : "Save",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        );
      },
    );
  }

  void addStudent(String selectedGender,
      {String? depart, String? imagepath, String? dob}) async {
    final name = nameController.text;
    final dep = depart;
    final age = rollController.text;
    final mobile = phoneController.text;

    // Use null-aware operator to provide a default value if imagepath is null
    final imagePath = imagepath ?? "";

    final details = StudentModel(
      dob: dob,
      gender: selectedGender,
      name: name,
      department: dep,
      rollNo: age,
      number: mobile,
      image: imagePath,
      id: -1,
    );
    db.save(details);
  }

  void showMySnackbar(BuildContext context, String topic) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text('${topic}'),
      backgroundColor: Colors.black45,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
