import 'package:dars_20_01_2023_firebase/google_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller.dart';
import 'facebook_page.dart';
import 'home_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key, required this.title});

  final String title;

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  List<Widget> list = [
    MyHomePage(
      title: 'Home Page',
    ),
    GooglePage(),
    FacebookPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: context.watch<AppController>().currentIndex,
        children: list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<AppController>().currentIndex,
        onTap: (value) {
          context.read<AppController>().setIndex(value);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Google"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Facebook"),
        ],
      ),
    );
  }
}
