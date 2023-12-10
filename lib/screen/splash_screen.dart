import 'dart:async';
import 'package:flutter/material.dart';
import '../navigator/navigator_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const NavigatorBar(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff01AF86),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/yaksisi_logo.png",
              height: height * 0.4,
              width: height * 0.4,
            ),
            CircularProgressIndicator(
              color: Colors.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}
