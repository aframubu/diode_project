import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'detail_page.dart';
import 'home.dart';        
import 'login.dart';
import 'splash_screen.dart';
import 'reward_page.dart';
import 'profile_page.dart';
import 'cart_model.dart';  

void main() {
runApp(
  ChangeNotifierProvider(
    create: (_) => CartModel(),
    child: MyApp(),
  ),
);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/detail': (context) => ProductDetailPage(),
        '/reward': (context) => RewardPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
