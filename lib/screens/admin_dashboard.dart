import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_button.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _addProduct(ProductProvider productProvider) {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: '', // Firestore will generate this
        name: _nameController.text.trim(),
        imageUrl: _imageController.text.trim(),
        price: double.tryParse(_priceController.text.trim()) ?? 0,
        category: _categoryController.text.trim(), description: '',
      );
      productProvider.addProduct(newProduct);

      // Clear form
      _nameController.clear();
      _imageController.clear();
      _priceController.clear();
      _categoryController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product added successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Add Product Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Product Name"),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: _imageController,
                    decoration: const InputDecoration(labelText: "Image URL"),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: "Category"),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: "Add Product",
                    onPressed: () => _addProduct(productProvider),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const Divider(),

            // Product List
            Expanded(
              child: FutureBuilder(
                future: productProvider.fetchProducts(),
                builder: (context, snapshot) {
                  final products = productProvider.products;
                  if (products.isEmpty) {
                    return const Text("No products available.");
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final p = products[index];
                      return ListTile(
                        leading: Image.network(p.imageUrl, width: 50, height: 50),
                        title: Text(p.name),
                        subtitle: Text("₹${p.price.toStringAsFixed(2)} • ${p.category}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => productProvider.deleteProduct(p.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
