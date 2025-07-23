import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../models/order.dart' as model; // Aliased to avoid name conflict

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future? get async => null;

  /// 🔄 Fetch all products from 'products' collection
  Future<List<Product>> getProducts() async {
    final snapshot = await _db.collection('products').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product.fromFirestore(data, doc.id);
    }).toList();
  }

  /// ➕ Add a product to 'products' collection
  Future<void> addProduct(Product product) async {
    await _db.collection('products').add({
      'name': product.name,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'category': product.category,
    });
  }

  Future<void> deleteProduct(String id) async {
    await _db.collection('products').doc(id).delete();
  }

  /// 🧾 Fetch orders for a user
  Future<List<model.Order>> fetchUserOrders(String userId) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map<model.Order>((doc) {
      final data = doc.data();
      return model.Order.fromFirestore(data, doc.id);
    }).toList();
  }

  /// 🧾 Place a new order for a user
  Future<void> placeOrder(model.Order order) async {
    await _db
        .collection('users')
        .doc(order.userId)
        .collection('orders')
        .add({
      'timestamp': order.timestamp,
      'total': order.totalAmount,
      'items': order.cartItems.map((item) => {
        'id': item.id,
        'name': item.name,
        'price': item.price,
        'imageUrl': item.imageUrl,
        'category': item.category,
      }).toList(),
    });
  }
}
