import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class DummyPaymentScreen extends StatelessWidget {
  const DummyPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Payment Gateway")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate payment
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Payment Successful!"),
                content: const Text("Thank you for your purchase."),
                actions: [
                  TextButton(
                    onPressed: () {
                      cart.clearCart(); // ✅ clear cart
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Back to cart
                      Navigator.of(context).pop(); // Back to product list
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          },
          child: const Text("Simulate Payment"),
        ),
      ),
    );
  }
}
