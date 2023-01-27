import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_20_01_2023_firebase/dars_24_25_01_2023/uy_ishi/university_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'get_university.dart';

class AddUniversityPage extends StatefulWidget {
  const AddUniversityPage({Key? key}) : super(key: key);

  @override
  State<AddUniversityPage> createState() => _AddUniversityPageState();
}

class _AddUniversityPageState extends State<AddUniversityPage> {
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController fee = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController rank = TextEditingController();
  TextEditingController website = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  String? logoPath;
  String? photoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEBF4F1),
        title: Text(
          "Add New University",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEBF4F1),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.4))),
                      child: logoPath == null
                          ? Center(child: Text("Logo"))
                          : ClipOval(
                              child: Image.file(
                              File(logoPath!),
                              fit: BoxFit.cover,
                            ))),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEBF4F1),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.4))),
                      child: photoPath == null
                          ? Center(child: Text("Photo"))
                          : ClipOval(
                              child: Image.file(
                              File(photoPath!),
                              fit: BoxFit.cover,
                            )))
                ],
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "Name",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: "Country",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                ),
              ),
              TextFormField(
                controller: location,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "Location",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: fee,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: "Tuition fee",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                ),
              ),
              TextFormField(
                controller: phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "Phone number",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: rank,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: "World Rank",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                ),
              ),
              TextFormField(
                controller: website,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "Website",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: Color(0xffEBF4F1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4))),
                        child: Text("Add Logo")),
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Add Logo"),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Gallery'),
                                onPressed: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  logoPath = image?.path;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Camera'),
                                onPressed: () async {
                                  final XFile? photo = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  logoPath = photo?.path;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: Color(0xffEBF4F1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4))),
                        child: Text("Add Photo")),
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Add Photo"),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Gallery'),
                                onPressed: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  photoPath = image?.path;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Camera'),
                                onPressed: () async {
                                  final XFile? photo = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  photoPath = photo?.path;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                        color: Color(0xffEBF4F1),
                        borderRadius: BorderRadius.circular(24),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.4))),
                    child: Text("Save"),
                  ),
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    final storageRefLogo = FirebaseStorage.instance
                        .ref()
                        .child("productImage/${DateTime.now().toString()}");
                    await storageRefLogo.putFile(File(logoPath ?? ""));

                    String urlLogo = await storageRefLogo.getDownloadURL();

                    final storageRefPhoto = FirebaseStorage.instance
                        .ref()
                        .child("productImage/${DateTime.now().toString()}");
                    await storageRefPhoto.putFile(File(photoPath ?? ""));

                    String urlPhoto = await storageRefPhoto.getDownloadURL();
                    firestore
                        .collection("university")
                        .add(UniversityModel(
                          name: name.text.toLowerCase(),
                          fee: double.tryParse(fee.text) ?? 0,
                          country: country.text,
                          website: website.text,
                          image: urlPhoto,
                          logo: urlLogo,
                          rank: double.tryParse(rank.text) ?? 0,
                          location: location.text,
                          phone: phone.text,
                        ).toJson())
                        .then(
                      (value) {
                        isLoading = false;
                        setState(() {});
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const GetUniversity()),
                            (route) => false);
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
