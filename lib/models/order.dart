import 'cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String userId;
  final List<CartItem> cartItems;
  final double totalAmount;
  final DateTime timestamp;

  Order({
    required this.userId,
    required this.cartItems,
    required this.totalAmount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cartItems': cartItems.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      userId: map['userId'],
      cartItems: (map['cartItems'] as List)
          .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item)))
          .toList(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  static fromFirestore(Map<String, dynamic> data, String id) {}
}
