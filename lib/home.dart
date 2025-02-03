import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview/color.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'OrderScreen.dart';
import 'home_page.dart';
import 'model.dart';
import 'favorites.dart';
import 'profile_page.dart';
import 'reward_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    OrderPage(),
    Favorites(),
    RewardPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor3 : Colors.white,
          borderRadius: BorderRadius.circular(12), // Add border radius here
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : Colors.grey, // Bold color when selected
                size: 22,
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.grey, // Bold color when selected
                  fontSize: 10,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal, // Bold when selected
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: _selectedIndex == 0 ? false : true,
        title: Text(
          _getTitle(_selectedIndex),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: _selectedIndex == 0
              ? TextAlign.start
              : TextAlign.center, // Conditional alignment
        ),

        // centerTitle: true, // Centers the title text
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(0xFF347c78),
            image: DecorationImage(
              image: AssetImage('asset/Frame 28 (1).png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
       
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        // padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, "Home"),
            _buildNavItem(1, Icons.shopping_cart, "Order"),
            _buildNavItem(2, Icons.favorite_border, "Favorite"),
            _buildNavItem(3, Icons.card_giftcard, "Rewards"),
            _buildNavItem(4, Icons.person, "Profile"),
          ],
        ),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'What are you craving \n today?';
      case 1:
        return 'Dalgona Coffee';
      case 2:
        return 'Favorites';
      case 3:
        return 'Rewards';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }
}
