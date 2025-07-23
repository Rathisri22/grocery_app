class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl, required category,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String docId) {
    return Product(
      id: docId,
      name: data['Name'] ?? '',
      description: data['Description'] ?? '',
      price: (data['Price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '', category: null,
    );
  }

  get category => null;

  toMap() {}

  static fromMap(Map<String, dynamic> map) {}
}
