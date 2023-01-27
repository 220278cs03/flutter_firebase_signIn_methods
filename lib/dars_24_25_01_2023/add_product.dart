import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_20_01_2023_firebase/dars_24_25_01_2023/product_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final storageRef = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product"),
        backgroundColor: Colors.blue.withOpacity(0.5),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              imagePath == null
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(0.5)),
                      child: Center(child: Text("Image")))
                  : Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(child: Image.file(File(imagePath!), fit: BoxFit.cover,))),
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
              SizedBox(height: 16,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.withOpacity(0.5),
                  ),
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    imagePath = image?.path;
                    setState(() {});
                  },
                  child: const Text("Add Image form gallery")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.withOpacity(0.5),
                  ),
                  onPressed: () async {
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    imagePath = photo?.path;
                    setState(() {});
                  },
                  child: const Text("Add Image")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.withOpacity(0.5),
                  ),
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child("productImage/${DateTime.now().toString()}");
                    await storageRef.putFile(File(imagePath ?? ""));

                    String url = await storageRef.getDownloadURL();

                    firestore
                        .collection("product")
                        .add(ProductModel(
                                name: nameController.text.toLowerCase(),
                                desc: descController.text,
                                price:
                                    double.tryParse(priceController.text) ?? 0,
                                image: url)
                            .toJson())
                        .then((value) {
                      isLoading = false;
                      setState(() {});
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const GetProduct()),
                          (route) => false);
                    });
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
