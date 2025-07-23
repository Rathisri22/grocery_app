import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_item.dart';
import '../models/order.dart' as model; // ✅ Use alias here too
import '../services/firestore_service.dart';

class OrderProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<model.Order> _orders = [];

  List<model.Order> get orders => _orders;

  Future<void> fetchOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _orders = await _firestoreService.fetchUserOrders(user.uid);
      notifyListeners();
    }
  }

  Future<void> placeOrder(List<CartItem> cartItems, double totalAmount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final order = model.Order(
        userId: user.uid,
        cartItems: cartItems,
        totalAmount: totalAmount,
        timestamp: DateTime.now(),
      );
      await _firestoreService.placeOrder(order);
      await fetchOrders();
    }
  }
}
