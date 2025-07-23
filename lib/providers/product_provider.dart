import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class ProductProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Product> _products = [];

  List<Product> get products => _products;

  /// 🔄 Fetch all products from Firestore
  Future<void> fetchProducts() async {
    try {
      _products = (await _firestoreService. async)!; {}();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }
  }

  /// ➕ Add a new product to Firestore and update local list
  Future<void> addProduct(Product product) async {
    try {
      await _firestoreService.addProduct(product);
      await fetchProducts(); // Refresh after adding
    } catch (e) {
      debugPrint("Error adding product: $e");
    }
  }

  /// ❌ Delete a product by ID and update local list
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestoreService.deleteProduct(productId);
      await fetchProducts(); // Refresh after deleting
    } catch (e) {
      debugPrint("Error deleting product: $e");
    }
  }
}
