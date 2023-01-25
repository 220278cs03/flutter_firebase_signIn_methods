import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_20_01_2023_firebase/dars_24_01_2023/product_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'get_product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextFormField(
            controller: descController,
            decoration: InputDecoration(labelText: "Desc"),
          ),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(labelText: "Price"),
          ),
          ElevatedButton(
              onPressed: () {
                firestore
                    .collection("product")
                    .add(ProductModel(
                            name: nameController.text,
                            desc: descController.text,
                            price: double.tryParse(priceController.text) ?? 0)
                        .toJson())
                    .then((value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => GetProduct()),
                        (route) => false));
              },
              child: Text("Save"))
        ],
      ),
    );
  }
}
