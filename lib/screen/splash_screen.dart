import 'dart:async';


import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';

import '../models/app_strings.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 3500), () => _goNext());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: TranslationAnimatedWidget.tween(
                  enabled: true,
                  translationDisabled: const Offset(0, 200),
                  translationEnabled: const Offset(0, 0),
                  delay: const Duration(microseconds: 1500),
                  child: OpacityAnimatedWidget.tween(
                    enabled: true,
                    opacityDisabled: 0,
                    opacityEnabled: 1,
                    child: Material(
                      elevation: 2,
                      shadowColor: Colors.white,
                      color: Colors.white,
                      type: MaterialType.circle,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.06,
                        backgroundColor: const Color.fromRGBO(253, 253, 253, 1),
                        child: Icon(Icons.local_parking,size: 35,)

                        /*Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(AppStrings.iconPath)))),*/
                      ),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Parking ".toUpperCase(),style: TextStyle(color: Colors.blue),),
                    Text("system ".toUpperCase()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
