

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';
import 'color.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar remains unchanged.
    appBar: AppBar(
        centerTitle: true, 
        elevation: 0, // Remove the shadow from the AppBar
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF347c78), // Background color
                  image: DecorationImage(
                    image: AssetImage('asset/Frame 28 (1).png'), // Background image
                    fit: BoxFit.cover, // Make the image cover the space
                  ),
                ),
              ),
            ),
            
          ],
        ),
        title: Text("Your Cart",style: TextStyle( color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // Wrap the entire body in a SafeArea to respect system UI boundaries.
      body: SafeArea(
        child: Consumer<CartModel>(
          builder: (context, cart, child) {
            return Container(
              color: Colors.grey[200],
              // Use a Column that stretches to fill the available space.
              child: Column(
                children: [
                  Expanded(
                    child: cart.cartItems.isEmpty
                        ? const Center(
                            child: Text(
                              "Your cart is empty",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: cart.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cart.cartItems[index];
                              return Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      item.imagePath,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    "${item.cupSize} Cup - ${item.milkOption} Milk",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      "Quantity: ${item.quantity}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  trailing: FittedBox(
                                    fit: BoxFit
                                        .scaleDown, // Scales down the child if needed.
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize
                                            .min, // Use minimal vertical space.
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "BHD ${item.price.toStringAsFixed(3)}",
                                            style:  TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: backgroundColor,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          IconButton(
                                            padding: EdgeInsets
                                                .zero, // Remove extra padding.
                                            constraints:
                                                const BoxConstraints(), // Remove default constraints.
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                              size:55, 
                                            ),
                                            onPressed: () {
                                              Provider.of<CartModel>(context,
                                                      listen: false)
                                                  .removeItem(item);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  // Adding extra bottom padding to ensure responsiveness.
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).padding.bottom + 16,
                      top: 16,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, -2),
                          ),
                        ],
                        borderRadius:  BorderRadius.circular(25)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "BHD ${cart.totalPrice.toStringAsFixed(3)}",
                            style:  TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
