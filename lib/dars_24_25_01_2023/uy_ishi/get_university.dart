import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_20_01_2023_firebase/dars_24_25_01_2023/uy_ishi/uni_info_page.dart';
import 'package:dars_20_01_2023_firebase/dars_24_25_01_2023/uy_ishi/university_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;

import 'add_university.dart';

class GetUniversity extends StatefulWidget {
  const GetUniversity({Key? key}) : super(key: key);

  @override
  State<GetUniversity> createState() => _GetUniversityState();
}

class _GetUniversityState extends State<GetUniversity> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<UniversityModel> list = [];
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
      data = await firestore.collection("university").get();
    } else {
      data = await firestore
          .collection("university")
          .orderBy("name")
          .startAt([text]).endAt(["$text\uf8ff"]).get();
    }
    list.clear();
    listOfDoc.clear();
    data?.docs.forEach((element) {
      list.add(UniversityModel.fromJson(element));
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
        title: Text(
          "Universities",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffEBF4F1),
        actions: [
          IconButton(
              onPressed: () async {
                const productLink = 'https://foodyman.org/';

                const dynamicLink =
                    'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyACgEtbfV8bWENK6BJV_k1kRxoai6pdPN4';

                final dataShare = {
                  "dynamicLinkInfo": {
                    "domainUriPrefix": 'https://dars20012023firebase.page.link',
                    "link": productLink,
                    "androidInfo": {
                      "androidPackageName":
                          'com.example.dars_20_01_2023_firebase',
                    },
                    "iosInfo": {
                      "iosBundleId": "com.example.dars20012023Firebase",
                    },
                    "socialMetaTagInfo": {
                      "socialTitle": "Your dream UNI",
                      "socialDescription": "Find out the best uni in the world",
                      "socialImageLink": 'Image',
                    }
                  }
                };

                final res = await http.post(Uri.parse(dynamicLink),
                    body: jsonEncode(dataShare));

                var shareLink = jsonDecode(res.body)['shortLink'];
                await FlutterShare.share(
                  text: "University",
                  title: "Your dream UNI",
                  linkUrl: shareLink,
                );

                print(shareLink);
              },
              icon: Icon(Icons.share, color: Colors.black,))
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                      blurRadius: 20)
                ]),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search University",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.withOpacity(0.6)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search)),
              onChanged: (s) {
                getInfo(text: s);
              },
            ),
          ),
        ),
        isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            margin:
                                EdgeInsets.only(top: 32, right: 16, left: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 10),
                                      spreadRadius: 0,
                                      blurRadius: 20)
                                ]),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: ClipOval(
                                    child: Image.network(list[index].logo),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      list[index].country,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite_border)),
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Color(0xffEBF4F1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => UniInfoPage(
                                                      uni: list[index],
                                                    )));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            )),
                        onLongPress: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(list[index].name),
                                content: const Text('Delete from list?'),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      firestore
                                          .collection("university")
                                          .doc(listOfDoc[index] ?? "")
                                          .delete()
                                          .then(
                                              (doc) =>
                                                  print("Document deleted"),
                                              onError: (e) {
                                        print(e);
                                      });
                                      list.removeAt(index);
                                      listOfDoc.removeAt(index);
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
                      );
                    }),
              ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffEBF4F1),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddUniversityPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
