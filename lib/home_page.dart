import 'package:dars_20_01_2023_firebase/controller.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    context.read<AppController>().AddCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              context.watch<AppController>().counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    GoogleSignIn _googleSignIn = GoogleSignIn();
                    var data = await _googleSignIn.signIn();
                    print(data?.id);
                    print(data?.email);
                    print(data?.photoUrl);
                    print(data?.displayName);
                    context.read<AppController>().getAvatar(data?.photoUrl ?? "");
                    context.read<AppController>().getName(data?.displayName ?? "");
                    context.read<AppController>().getEmail(data?.email ?? "");
                    setState(() {});
                    _googleSignIn.signOut();
                  } catch (e) {
                    print("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR : $e");
                  }
                },
                child: Text("Google sign in")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
