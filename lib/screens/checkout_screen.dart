import 'package:flutter/material.dart';
import 'package:grocery_fixed/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/custom_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.cartItems.isEmpty
                ? const Center(child: Text("Your cart is empty."))
                : ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemTile(cartItem: cartProvider.cartItems[index]);
                    },
                  ),
          ),
          if (cartProvider.cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Total: ₹${cartProvider.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: "Place Order",
                    onPressed: () async {
                      await orderProvider.placeOrder(
                        cartProvider.cartItems.cast<CartItem>(),
                        cartProvider.totalPrice,
                      );
                      cartProvider.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Order placed successfully!")),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
