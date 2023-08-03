import 'dart:async';

import 'package:covid_tracker_app/View/world_state_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  void initState() {

    super.initState();
   Timer(const Duration(seconds: 5), () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStateScreen()));
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            child: Container(
              width: 200,
              height: 200,
              child: Center(
                child: Image.asset('assets/images/im_logo.jpeg'),
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * math.pi,
                child: child,
              );
            },
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text('Covid-19 \n Tracker App',textAlign:TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 25),),
          )
        ],
      ),
    );
  }
}

// ! 1