
import 'package:flutter/material.dart';
import 'package:interview/color.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'cart.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String _selectedCupSize = "Medium";
  String _selectedMilkOption = "Regular";
  int _quantity = 1;
  Set<int> _favoriteIds = {}; // Store favorite product IDs
  int productId = 1; // Example product ID to simulate favoriting logic

  bool get isFavorite => _favoriteIds.contains(productId);

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteIds.contains(productId)) {
        _favoriteIds.remove(productId);
      } else {
        _favoriteIds.add(productId);
      }
    });
  }

  Widget _buildtextcontainer() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              child: Image.asset(
                "asset/Mask group.png",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -60,
              left: 30,
              right: 30,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dalgona Coffee",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text("4.8 (236)"),
                              SizedBox(width: 45),
                              Text("16 min"),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            "BHD 18.000",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleFavorite(productId),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Replace with your backgroundColor variable if needed.
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildtextcontainer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const Center(
                    child: Text(
                      "Cup Size",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Small", "Medium", "Large"].map((size) {
                      return Column(
                        children: [
                          Image.asset("asset/tabler-icon-cup.png"),
                          ChoiceChip(
                            label: Text(
                              size,
                              style: TextStyle(
                                color: _selectedCupSize == size
                                    ? backgroundColor
                                    : Colors.white,
                              ),
                            ),
                            selected: _selectedCupSize == size,
                            backgroundColor:backgroundColor,
                            selectedColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                _selectedCupSize = size;
                              });
                            },
                            showCheckmark: false,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white, thickness: 1),
                  const Center(
                    child: Text(
                      "Milk Options",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Regular", "Skimmed", "Whole"].map((option) {
                      return ChoiceChip(
                        label: Text(
                          option,
                          style: TextStyle(
                            color: _selectedMilkOption == option
                                ? backgroundColor
                                : Colors.white,
                          ),
                        ),
                        selected: _selectedMilkOption == option,
                        backgroundColor: backgroundColor,
                        selectedColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedMilkOption = option;
                          });
                        },
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white, thickness: 1),
                  const Center(
                    child: Text(
                      "Count",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _decrementQuantity,
                            child: Container(
                              width: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "$_quantity",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: _incrementQuantity,
                            child: Container(
                              width: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Add to Cart Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor3,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        // Calculate price based on quantity (for this example, each item is BHD 18.000)
                        double pricePerItem = 18.0;
                        double totalPrice = pricePerItem * _quantity;
                        
                        // Create a new CartItem
                        final newItem = CartItem(
                          cupSize: _selectedCupSize,
                          milkOption: _selectedMilkOption,
                          quantity: _quantity,
                          price: totalPrice,
                          imagePath: "asset/Mask group.png", // or another appropriate image path
                        );

                        // Add the new item to the CartModel via Provider.
                        Provider.of<CartModel>(context, listen: false).addItem(newItem);

                        // Navigate to the CartPage.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Add to cart ",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Container(
                            height: 25,
                            child: const VerticalDivider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            "BHD ${(18.0 * _quantity).toStringAsFixed(3)}",
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
