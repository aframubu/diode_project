import 'package:flutter/material.dart';
import 'package:interview/color.dart';
import 'package:lottie/lottie.dart';

class RewardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Congratulations!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: backgroundColor3),
              textAlign: TextAlign.center,
            ),
              Text(
              "You are now upgraded to Gold Tier!",
              style: TextStyle(fontWeight: FontWeight.bold,color: backgroundColor4),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40), // Added spacing
            Center(
              child: Lottie.asset(
                'asset/animation/222.json', // Ensure correct path
                width: 400,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20,),
             Text(
              "Access Loyalty Tier benefits and \n redeem it with ease",
              style: TextStyle(fontWeight: FontWeight.bold,color: backgroundColor4),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
           Image.asset("asset/Frame 27.png"),
            SizedBox(height: 25,),
           Image.asset("asset/Frame 25.png")
          ],
        ),
      ),
    );
  }
}
