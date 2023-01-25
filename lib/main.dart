import 'package:dars_20_01_2023_firebase/dars_21_01_2023/add_number.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'dars_21_01_2023/bottomNavigation_page.dart';
import 'dars_21_01_2023/controller.dart';
import 'dars_24_01_2023/get_product.dart';
import 'dars_24_01_2023/uy_ishi/get_university.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppController()),
      ],
      child: MaterialApp(
        home: GetUniversity(),
      ),
    );
  }
}
