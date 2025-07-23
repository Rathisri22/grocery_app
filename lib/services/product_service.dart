import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          id: data['id'],
          name: data['name'],
          imageUrl: data['imageUrl'],
          price: (data['price'] as num).toDouble(),
          category: data['category'], description: '',
        );
      }).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  // Update a product
  Future<void> updateProduct(Product product) async {
    try {
      await _firestore.collection('products').doc(product.id).update({
        'name': product.name,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'category': product.category,
      });
    } catch (e) {
      print("Error updating product: $e");
    }
  }
}
