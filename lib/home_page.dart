

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview/ViewAllScreen.dart';
import 'package:interview/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

import 'OrderScreen.dart';
import 'model.dart';
import 'favorites.dart';
import 'profile_page.dart';
import 'reward_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  bool _isLoading = true;
  bool _hasError = false;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');

    if (storedToken != null) {
      setState(() {
        _token = storedToken;
      });
      _fetchProducts();
    } else {
      log("Token not found, redirecting to login.");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  Future<void> _fetchProducts() async {
    if (_token == null) {
      log("Token is null, cannot fetch products.");
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      return;
    }

    final url = Uri.parse('https://mt.diodeinfosolutions.com/api/get-products');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': ' $_token',
          'Content-Type': 'application/json',
        },
      );

      log('API Response: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        log('Parsed Response Data: $responseData');

        if (responseData is List && responseData.length > 1) {
          setState(() {
            _products = responseData
                .skip(1)
                .map((productJson) =>
                    Product.fromJson(productJson as Map<String, dynamic>))
                .toList();
            _isLoading = false;
            _hasError = false;
          });
        } else {
          log("Error: Invalid data format or insufficient data.");
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
      } else {
        log("Error: Failed to load products, status code: ${response.statusCode}");
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (error) {
      log('Error fetching products: $error');
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Widget _buildAppBarWithCarousel() {
    List<String> staticImageUrls = [
      'asset/Mask group (2).png',
      'asset/Mask group (3).png',
      'asset/Mask group (4).png',
    ];

    return Stack(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF347c78),
            image: DecorationImage(
              image: AssetImage('asset/Frame 28 (1).png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Align items vertically
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 2),
                      child: Icon(Icons.location_searching_sharp,
                          color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      // Allows text to wrap/shrink properly
                      child: Text(
                        "19290 Al Fateh Grand Mosque Road, Bahrain",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 45),
                  child: Icon(Icons.arrow_drop_down_circle_outlined,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "What are you looking for?",
                    suffixIcon: Icon(Icons.menu_outlined, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: staticImageUrls.length,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1), // Adds spacing between items
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(staticImageUrls[index],
                            fit: BoxFit.cover, width: 300),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 120,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendingProducts(List<Product> products) {
    final trendingProducts = products.take(2).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 6,
        childAspectRatio: 0.85,
      ),
      itemCount: trendingProducts.length,
      itemBuilder: (context, index) {
        var product = trendingProducts[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'asset/download.png',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: backgroundColor)),
                    Row(
                      children: [
                        Icon(Icons.star, color: backgroundColor3, size: 18),
                        SizedBox(width: 5),
                        Text(product.rating.toString(),
                            style: TextStyle(color: backgroundColor4)),
                        Spacer(),
                        Text(product.makingTime,
                            style: TextStyle(color: backgroundColor4)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                        "${product.currency.name} ${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: backgroundColor3,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageGrid(List<String> staticImageUrls, List<String> labels) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 images per row
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1, // Keep aspect ratio square
      ),
      itemCount: staticImageUrls.length,
      itemBuilder: (context, index) {
        var imageUrl = staticImageUrls[index];
        var label = labels[index]; // Get the corresponding label

        return Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align to top
          children: [
            ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 50, color: Colors.grey);
                },
              ),
            ),
            SizedBox(height: 4), // Reduce space between image and text
            Container(
              width: 60, // Restrict width to prevent text wrapping
              alignment: Alignment.center,
              child: Text(
                label,
                maxLines: 1, // Ensure text stays in one line
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor4),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> staticImageUrls = [
      'asset/1.png',
      'asset/2.png',
      'asset/Mask group (4).png',
      'asset/4.png',
      'asset/5.png',
      'asset/6.png',
      'asset/Mask group (2).png',
      'asset/8.png',
    ];

    List<String> labels = [
      'Cold Brew',
      'Arabica Beans',
      'Cheese Cake',
      'Croissants',
      'Mocha',
      'Americano',
      'Espresso',
      'Tiramisu'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBarWithCarousel(),

            // Trending Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Trending",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor),
                      ),
                      SizedBox(width: 6), // Spacing between text and number
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: backgroundColor3,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "16",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewAllScreen(products: _products)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "View all",
                          style: TextStyle(color: backgroundColor),
                        ),
                        SizedBox(width: 16), // Spacing between text and icon
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: backgroundColor,
                        ), // Small forward arrow
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Trending Products
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildTrendingProducts(_products),
            SizedBox(
              height: 10,
            ),

            _buildImageGrid(staticImageUrls,
                labels), // Ensure space at the bottom to avoid overflow
          ],
        ),
      ),
    );
  }
}
