import 'package:dars_20_01_2023_firebase/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children : [
            Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle
                ),
                child: context.watch<AppController>().avatar != null ?  ClipOval(child: Image.network(context.watch<AppController>().avatar, fit: BoxFit.cover,)) : Center(child: Text("IMAGE"))
            ),
            SizedBox(height: 16,),
            Text(context.watch<AppController>().name),
            SizedBox(height: 16,),
            Text(context.watch<AppController>().email),

          ]
        ),
      ),
    );
  }
}
