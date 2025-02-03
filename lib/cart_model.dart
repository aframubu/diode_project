import 'package:flutter/material.dart';
import 'model.dart'; // Ensure that this file contains your Product model if needed.

class CartModel with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  /// Returns the total price of all items in the cart.
  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price; // Assumes each CartItem has a 'price' property.
    }
    return total;
  }

  /// Adds an item to the cart.
  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  /// Removes an item from the cart.
  void removeItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  /// Clears all items from the cart.
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class CartItem {
  final String cupSize;
  final String milkOption;
  final int quantity;
  final double price;
  final String imagePath;

  CartItem({
    required this.cupSize,
    required this.milkOption,
    required this.quantity,
    required this.price,
    required this.imagePath,
  });
}
