import 'package:student_db/add_datas.dart';
import 'package:student_db/detials.dart';
import 'package:student_db/searchScreen.dart';
import 'package:student_db/studentsAllDats.dart';

List images = [
  {
    'image': 'https://www.zica.org/images/icon-student.jpg',
    'name': 'Student List'
  },
  {
    'image':
        'https://th.bing.com/th/id/OIP.82VobEiG7hdu9KkrASax6wHaHa?pid=ImgDet&w=200&h=200&c=7&dpr=1.3',
    'name': 'Add Student'
  },
  {
    'image':
        'https://img.freepik.com/free-vector/graphic-design-creative-process-concept_52683-5328.jpg?size=626&ext=jpg&ga=GA1.1.264453031.1702742157&semt=ais',
    'name': 'Search Student'
  },
  {
    'image':
        'https://th.bing.com/th?id=OIP.KYURz49qg0-zt7xS4gUO-wHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'name': 'Department'
  },
];
List navigators = [
  studentsListingPage(),
  Add_Screen(
    isEdit: false,
  ),
  SearchScreen(),
  DepartmentCategory(),
];
List<String> categories = [
  'Select Department',
  'Computer Engineering',
  'Mechanical Engineering',
  'Electronic Engineering',
  'Civil Engineering',
];
List<String> categ = [
  'Computer Engineering',
  'Mechanical Engineering',
  'Electronic Engineering',
  'Civil Engineering',
];
