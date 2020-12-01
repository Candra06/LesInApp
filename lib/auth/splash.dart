import 'package:flutter/material.dart';
import 'package:lesin_app/auth/login.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:lesin_app/siswa/home/home.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller.forward();

    Future.delayed(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
          PageTransition(child: LoginPage(), type: PageTransitionType.fade));
      String token = await Config.getToken();
        if (token == '' || token == null) {
          Navigator.of(context).pushReplacement(PageTransition(
              child: LoginPage(), type: PageTransitionType.fade));
        }
        else {
          Navigator.of(context).pushReplacement(
              PageTransition(child: Home(indexPage: 0.toString(),), type: PageTransitionType.fade));
        }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Bulet bulet
          Positioned(
              //bulet pojok kiri
              top: -(displayWidth(context) * 0.18),
              left: -(displayWidth(context) * 0.3),
              child: FadeAnimation(
                0.5,
                Container(
                  height: displayWidth(context) * 0.69,
                  width: displayWidth(context) * 0.69,
                  decoration: BoxDecoration(
                      color: Config.secondary,
                      borderRadius: BorderRadius.all(
                          Radius.circular(displayWidth(context) * 0.5))),
                ),
              )),

          Positioned(
              // bulet pojok kiri 2
              top: -(displayWidth(context) * 0.1),
              left: (displayWidth(context) * 0.1),
              child: FadeAnimation(
                0.6,
                Container(
                  height: displayWidth(context) * 0.45,
                  width: displayWidth(context) * 0.45,
                  decoration: BoxDecoration(
                      color: Config.primary.withOpacity(0.7),
                      borderRadius: BorderRadius.all(
                          Radius.circular(displayWidth(context) * 0.5))),
                ),
              )),

          Positioned(
              //bulet pojok kanan
              bottom: -(displayWidth(context) * 0.3),
              right: -(displayWidth(context) * 0.3),
              child: FadeAnimation(
                0.1,
                Container(
                  height: displayWidth(context) * 0.69,
                  width: displayWidth(context) * 0.69,
                  decoration: BoxDecoration(
                      color: Config.secondary,
                      borderRadius: BorderRadius.all(
                          Radius.circular(displayWidth(context) * 0.5))),
                ),
              )),

          Positioned(
              // bulet pojok kanan 2
              bottom: (displayWidth(context) * 0.1),
              right: -(displayWidth(context) * 0.2),
              child: FadeAnimation(
                0.2,
                Container(
                  height: displayWidth(context) * 0.45,
                  width: displayWidth(context) * 0.45,
                  decoration: BoxDecoration(
                      color: Config.primary.withOpacity(0.7),
                      borderRadius: BorderRadius.all(
                          Radius.circular(displayWidth(context) * 0.5))),
                ),
              )),

          ScaleTransition(
            scale: animation,
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          )
          //
        ],
      ),
    );
  }
}
