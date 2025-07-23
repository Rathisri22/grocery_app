import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final id = const Uuid().v4(); // unique id
    await FirebaseFirestore.instance.collection('products').doc(id).set({
      'id': id,
      'name': nameController.text,
      'imageUrl': imageUrlController.text,
      'price': double.parse(priceController.text),
      'category': categoryController.text,
    });

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: "Image URL"),
                validator: (value) =>
                    value!.isEmpty ? "Enter image URL" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
                validator: (value) =>
                    value!.isEmpty ? "Enter category" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Add Product"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
