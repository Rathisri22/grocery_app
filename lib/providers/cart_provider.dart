// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _items = []; // ✅ Always initialized

  List<Product> get items => _items;

  get cartItems => null;

  get totalPrice => null;

  void addToCart(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<void> checkoutCart() async {}
}
