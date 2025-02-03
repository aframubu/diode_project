import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:interview/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>> _products = [
    {
      "id": 1,
      "name": "Dalgona Coffee",
      "price": 18.0,
      "time": "09-01-2025 | 10:29 AM", // Time as a string
      "imageUrl": "asset/Mask group.png", // Ensure it's correct path
      "currency": "BHD",
      "status": "Order placed."
    },
    {
      "id": 2,
      "name": "Latte",
      "price": 12.5,
      "time": "08-01-2025 | 11:15 AM",
      "rating": 4.5,
      "imageUrl": "asset/Mask group (6).png", // Ensure it's correct path
      "currency": "BHD",
      "status": "Delivered."
    },
    {
      "id": 3,
      "name": "Espresso",
      "price": 10.0,
      "time": "09-01-2025 | 11:15 AM",
      "imageUrl": "asset/Mask group (2).png", // Ensure it's correct path
      "currency": "BHD",
      "status": "Delivered."
    },
    {
      "id": 4,
      "name": "Espresso",
      "price": 10.0,
      "time": "06-01-2025 | 11:15 AM",
      "imageUrl": "asset/Mask group (3).png", // Ensure it's correct path
      "currency": "BHD",
      "status": "Delivered."
    },
    {
      "id": 5,
      "name": "Espresso",
      "price": 10.0,
      "time": "05-01-2025 | 11:15 AM",
      "imageUrl": "asset/Mask group (4).png", // Ensure it's correct path
      "currency": "BHD",
      "status": "Delivered."
    },
    {
      "id": 6,
      "name": "Espresso",
      "price": 10.0,
      "time": "04-01-2025 | 11:15 AM",
      "imageUrl": "asset/Mask group (5).png", // Ensure it's correct path
      "currency": "BHD",
      "status": "Delivered."
    },
  ];

  bool _isLoading = false;
  bool _hasError = false;
  String? _token;
  Set<int> _favoriteIds = {};
  List<Map<String, dynamic>> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadToken();
    _filteredProducts = _products; // Initialize filtered list with all products
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');

    if (storedToken != null) {
      setState(() {
        _token = storedToken;
      });
    } else {
      log("Token not found, redirecting to login.");
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  /// Toggle favorite status
  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteIds.contains(productId)) {
        _favoriteIds.remove(productId);
      } else {
        _favoriteIds.add(productId);
      }
    });
  }

  /// Filter products based on the search term
  void _filterProducts(String searchTerm) {
    setState(() {
      _filteredProducts = _products
          .where((product) =>
              product['name'].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true, // Centers the title text
          elevation: 0, // Remove the shadow from the AppBar
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
                      fit: BoxFit.cover, // Make the image cover the space
                    ),
                  ),
                ),
              ),
              // Content (Search bar, title, etc.)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  // Wrap the Column with SingleChildScrollView
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          width: 350, // Reduced size of the search bar
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Background color for the search bar
                            borderRadius: BorderRadius.circular(
                                5), // Added border radius to the search bar
                          ),
                          child: Row(
                            children: [
                              // TextField on the right side
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: "What are you looking for?",
                                    hintStyle: TextStyle(
                                        color:
                                            Colors.black54), // Darker hint text
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            16), // Padding inside the search bar
                                  ),
                                  style: TextStyle(
                                      color: Colors
                                          .black), // Black text for search bar
                                  onChanged: (value) {
                                    _filterProducts(
                                        value); // Update filtered products on search
                                  },
                                ),
                              ),
                              // Menu Icon on the left side
                              IconButton(
                                icon: Icon(Icons.menu), // Menu icon
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _hasError
                ? Center(child: Text("Error fetching products."))
                : _filteredProducts.isEmpty
                    ? Center(child: Text("No products found"))
                    : ListView.builder(
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          var product = _filteredProducts[index];

                          // Debug log to check if time and status are available
                          log("Product ID: ${product['id']}, Time: ${product['time']}, Status: ${product['status']}");

                          bool isFavorite =
                              _favoriteIds.contains(product['id']);

                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            color: Colors.white,
                            child: Row(
                              children: [
                                // Left side content (image)
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      product['imageUrl'],
                                      width: double.infinity,
                                      height: 115,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                // Right side content (text)
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            height:
                                                4), // Space between name and rating

                                        Text(
                                          product['time'] ??
                                              'Time not available', // Default message if time is null
                                          style: TextStyle(
                                              color: backgroundColor3),
                                        ),
                                        SizedBox(
                                            height: 8), // Space after rating
                                        Text(
                                          "${product['price']} ${product['currency']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ), // Space between time and status
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          product['status'] ??
                                              'Status not available', // Default message if status is null
                                          style: TextStyle(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //  Spacer(),
               Icon(
                 Icons.arrow_forward_ios,
                 color:backgroundColor3,
               ),
                              ],
                            ),
                          );
                        },
                      ));
  }
}
