import 'package:dars_20_01_2023_firebase/dars_21_01_2023/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GooglePage extends StatelessWidget {
  const GooglePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: context.watch<AppController>().avatar == ""
                  ? Center(child: Text("IMAGE"))
                  : ClipOval(
                      child: Image.network(
                      context.watch<AppController>().avatar,
                      fit: BoxFit.cover,
                    ))),
          SizedBox(
            height: 16,
          ),
          Text(context.watch<AppController>().name),
          SizedBox(
            height: 16,
          ),
          Text(context.watch<AppController>().email),
        ]),
      ),
    );
  }
}
