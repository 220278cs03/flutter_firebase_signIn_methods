import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dars_21_01_2023/controller.dart';

class FacebookPage extends StatefulWidget {
  const FacebookPage({Key? key}) : super(key: key);

  @override
  State<FacebookPage> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: context.watch<AppController>().facebook_image == "IMAGE"
                  ? const Center(child: Text("IMAGE"))
                  : ClipOval(
                      child: Image.network(
                      context.watch<AppController>().facebook_image,
                      fit: BoxFit.cover,
                    ))),
          const SizedBox(
            height: 16,
          ),
          Text(context.watch<AppController>().facebook_name),
          const SizedBox(
            height: 16,
          ),
          Text(context.watch<AppController>().facebook_id),
        ]),
      ),
    );
  }
}
