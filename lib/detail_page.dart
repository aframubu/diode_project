import 'package:flutter/material.dart';
import 'model.dart'; 

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the product passed as an argument to the route
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl), // Display the product image
            SizedBox(height: 16),
            Text(product.name, style: TextStyle(fontSize: 24)),
            Text('Price: ${product.price} ${currencyValues.reverse[product.currency]}'),
            // Add more product details as needed
          ],
        ),
      ),
    );
  }
}
