import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;

class DynamicLinkPage extends StatefulWidget {
  const DynamicLinkPage({Key? key}) : super(key: key);

  @override
  State<DynamicLinkPage> createState() => _DynamicLinkPageState();
}

class _DynamicLinkPageState extends State<DynamicLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Link"),
      ),
      body: Center(
        child: Text("Genetare link"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const productLink = 'https://foodyman.org/';

          const dynamicLink =
              'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyACgEtbfV8bWENK6BJV_k1kRxoai6pdPN4';

          final dataShare = {
            "dynamicLinkInfo": {
              "domainUriPrefix": 'https://dars20012023firebase.page.link',
              "link": productLink,
              "androidInfo": {
                "androidPackageName": 'com.example.dars_20_01_2023_firebase',
              },
              "iosInfo": {
                "iosBundleId": "com.example.dars20012023Firebase",
              },
              "socialMetaTagInfo": {
                "socialTitle": "Title",
                "socialDescription": "Description: Description",
                "socialImageLink": 'Image',
              }
            }
          };

          final res = await http.post(Uri.parse(dynamicLink),
              body: jsonEncode(dataShare));

          var shareLink = jsonDecode(res.body)['shortLink'];
          await FlutterShare.share(
            text:  "Foodyman",
            title:  "ytrew",
            linkUrl: shareLink,
          );

          print(shareLink);
        },
        child: Text("+"),
      ),
    );
  }
}