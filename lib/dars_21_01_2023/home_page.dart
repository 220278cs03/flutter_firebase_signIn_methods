import 'package:dars_20_01_2023_firebase/dars_21_01_2023/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
                    context
                        .read<AppController>()
                        .getAvatar(data?.photoUrl ?? "");
                    context
                        .read<AppController>()
                        .getName(data?.displayName ?? "");
                    context.read<AppController>().getEmail(data?.email ?? "");
                    setState(() {});
                    _googleSignIn.signOut();
                  } catch (e) {
                    print("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR : $e");
                  }
                },
                child: Text("Google sign in")),
            ElevatedButton(
              onPressed: () async {
                // Create an instance of FacebookLogin
                final fb = FacebookLogin();

// Log in
                final res = await fb.logIn(permissions: [
                  FacebookPermission.publicProfile,
                  FacebookPermission.email,
                ]);

// Check result status
                switch (res.status) {
                  case FacebookLoginStatus.success:
                    // Logged in

                    // Send access token to server for validation and auth
                    final FacebookAccessToken? accessToken = res.accessToken;
                    print('Access token: ${accessToken?.token}');

                    // Get profile data
                    final profile = await fb.getUserProfile();
                    //----------------------------------------------------------------------------
                    context
                        .read<AppController>()
                        .getFacebookName(profile?.name ?? "NAME");
                    context
                        .read<AppController>()
                        .getFacebookId(profile?.userId ?? "ID");
                    //----------------------------------------------------------------------------
                    print(
                        'Hello, ${profile?.name}! You ID: ${profile?.userId}');

                    // Get user profile image url
                    final imageUrl = await fb.getProfileImageUrl(width: 100);
                    print('Your profile image: $imageUrl');
                    //-----------------------------------------------------------------------------
                    context
                        .read<AppController>()
                        .getFacebookImage(imageUrl ?? "");
                    //-----------------------------------------------------------------------------

                    // Get email (since we request email permission)
                    final email = await fb.getUserEmail();
                    // But user can decline permission
                    if (email != null) print('And your email is $email');

                    break;
                  case FacebookLoginStatus.cancel:
                    // User cancel log in
                    break;
                  case FacebookLoginStatus.error:
                    // Log in failed
                    print('Error while log in: ${res.error}');
                    break;
                }
              },
              child: Text("Facebook"),
            )
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
