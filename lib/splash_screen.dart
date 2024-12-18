import 'dart:async'; // Import for Timer
import 'package:auto_route/annotations.dart';
import 'package:demofirst/rest/hive_repo.dart';
import 'package:demofirst/routes/app_router.gr.dart';
import 'package:demofirst/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<double> _animationLeft;
  late Animation<double> _animationRight;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _animationLeft = Tween(begin: -500.0, end: 70.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _animationRight = Tween(begin: 200.0, end: 70.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });

    Timer(const Duration(seconds: 3), () {
      if(HiveRepo.instance.getUserValue() == "true"){
        context.router.replace(HomeRoute());
      } else {
        context.router.replace(LoginRoute());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
            color: screenBackgroundColor,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0XFF1875D3),
                  backgroundColor
                ]
            )
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationLeft,
              builder: (context, child) {
                return Positioned(
                  left: _animationLeft.value,
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: child!,
                );
              },
              child: Text(
                "Azinova",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animationRight,
              builder: (context, child) {
                return Positioned(
                  right: _animationRight.value,
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: child!,
                );
              },
              child: Text(
                "Demo App",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
