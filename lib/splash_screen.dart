


import 'package:flutter/material.dart';
import 'package:interview/color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

     _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: backgroundColor2,
        child: Stack(
          children: [
            // Top-right positioned image
            Positioned(
              right: screenWidth * 0.02, 
              height: screenHeight * 0.55, 
              child: Image.asset(
                'asset/Group.png',
                fit: BoxFit.fill, 
              ),
            ),
            
            // Bottom-left positioned image
            Positioned(
              bottom: -screenHeight * 0.05, 
              height: screenHeight * 0.50, 
              child: Image.asset(
                'asset/Isolation_Mode.png',
                fit: BoxFit.fill, 
              ),
            ),
            
            
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  'asset/5f1c1df569d560d2595d2900ae8090e1.png',
                  width: screenWidth * 0.8, 
                  height: screenWidth * 0.5, 
                  fit: BoxFit.fill, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
