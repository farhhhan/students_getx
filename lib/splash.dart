import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_db/model/main.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    // TODO: implement initState
    loadingTrending();
    super.initState();
  }

  Future<void> loadingTrending() async {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHdtTyyux4oerpt67J0lhxveOS_57YNKRX4oSMRWomKYKoWegi3gF0fRszUKObX5-rwf6rCzf12O-A4Y3Td5kN3_9InS3s1J464k5EM8BiX2ccGGjDvpzOaax5axy_pC3LfwUKjSY-noWnfOI_qGa-GCr3BgF_363oRNlMOAwZbdNYXGHhhOmomVpv/s1600/4-1-unnamed.gif",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
