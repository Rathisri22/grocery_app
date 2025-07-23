import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItemTile extends StatelessWidget {
  final Product cartItem; 

  const CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartItem.imageUrl, width: 50, height: 50),
      title: Text(cartItem.name),
      subtitle: Text("₹${cartItem.price.toStringAsFixed(2)}"),
    );
  }
}
