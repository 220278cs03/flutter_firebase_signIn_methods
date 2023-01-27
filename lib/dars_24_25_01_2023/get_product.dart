import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_20_01_2023_firebase/dars_24_25_01_2023/product_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../dars_26_01_2023/dynamic_links.dart';
import 'add_product.dart';

class GetProduct extends StatefulWidget {
  const GetProduct({Key? key}) : super(key: key);

  @override
  State<GetProduct> createState() => _GetProductState();
}

class _GetProductState extends State<GetProduct> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductModel> list = [];
  QuerySnapshot? data;
  bool isLoading = true;
  List listOfDoc = [];

  Future<void> getInfo({String? text}) async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   print("onBackgroundMessage");
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage");
    });

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    isLoading = true;
    setState(() {});
    if (text == null) {
      data = await firestore.collection("product").get();
    } else {
      data = await firestore
          .collection("product")
          .orderBy("name")
          .startAt([text]).endAt(["$text\uf8ff"]).get();
    }
    list.clear();
    listOfDoc.clear();
    data?.docs.forEach((element) {
      list.add(ProductModel.fromJson(element));
      listOfDoc.add(element.id);
    });
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.5),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search Product",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
              ),
              onChanged: (s) {
                getInfo(text: s);
              },
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        list[index].image == ""
                            ? SizedBox.shrink()
                            : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
                              child: Image.network(
                                list[index].image!, fit: BoxFit.cover,),
                            )),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(list[index].name),
                              Text(list[index].desc),
                              Text(list[index].price.toString()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(onPressed: () {
                            firestore.collection("product").doc(
                                listOfDoc[index] ?? "").delete().then((doc) =>
                                print("Document deleted"),
                            onError: (e){
                                  print(e);
                            });
                            list.removeAt(index);
                            listOfDoc.removeAt(index);
                            setState(() {});
                          }, icon: Icon(Icons.delete)),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue.withOpacity(0.5),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddProductPage()));
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue.withOpacity(0.5),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => DynamicLinkPage()));
            },
            child: Icon(Icons.link),
          ),
        ],
      ),
    );
  }
}
