import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_db/model/externalDatas.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 80,
        title: Text(
          'Student App',
          style: GoogleFonts.lato(
            color: Colors.white,
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/study-from-home-online-classes-concept-illustration_188398-1097.jpg?uid=R125219215&ga=GA1.1.264453031.1702742157&semt=ais'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 100,
                width: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/flat-university-concept-background_23-2148192775.jpg?uid=R125219215&ga=GA1.1.264453031.1702742157&semt=ais'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ],
          ),
          Expanded(
              child: GridView.builder(
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2.8,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(images[index]['image']),
                              fit: BoxFit.contain),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            height: 15,
                            color: Colors.black,
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            child: Center(
                                child: Text(
                              "${images[index]['name']}",
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            )),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
