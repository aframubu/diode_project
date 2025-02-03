import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview/color.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'OrderScreen.dart';
import 'model.dart';
import 'favorites.dart';
import 'profile_page.dart';
import 'reward_page.dart';

class ViewAllScreen extends StatelessWidget {
  final List<Product> products;

  ViewAllScreen({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Centers only the default title widget
        elevation: 0, // Removes shadow
        backgroundColor: Colors.transparent, // Keeps background clear
        flexibleSpace: Stack(
          children: [
            // Background image and color overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF347c78), // Background color
                  image: DecorationImage(
                    image: AssetImage(
                        'asset/Frame 28 (1).png'), // Background image
                    fit: BoxFit.cover, // Cover the space
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          "All Products",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16), // Spacing from the right edge
            child: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    product.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'asset/download.png', // Path to your local fallback image
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align everything to the start
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Adjust font size as needed
                        ),
                        textAlign: TextAlign
                            .start, // Ensures the product name starts at the left
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.star,
                            color: backgroundColor3, // Your custom color
                            size: 20, // Adjust size of the star
                          ),
                        ),
                        SizedBox(
                            width:
                                5), // Add space between the star and the rating text
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            product.rating.toString(),
                            style: TextStyle(
                                fontWeight:
                                    FontWeight.bold), // Bold rating text
                          ),
                        ),
                        Spacer(), // This will take up remaining space between the rating and making time
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            product.makingTime,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${product.currency.name} ${product.price.toStringAsFixed(2)}",
                        style: TextStyle(color: backgroundColor3),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
