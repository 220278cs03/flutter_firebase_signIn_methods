import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyPage extends StatefulWidget {
  final String verId;

  const VerifyPage({Key? key, required this.verId}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Code"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: PinFieldAutoFill(
              controller: controller,
              currentCode: "sss",
              codeLength: 8,
              cursor: Cursor(color: Colors.black, enabled: true, width: 2),
              decoration: const BoxLooseDecoration(
                  gapSpace: 10,
                  bgColorBuilder: FixedColorBuilder(Colors.white),
                  strokeColorBuilder: FixedColorBuilder(Colors.black)),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verId, smsCode: controller.text);
                var data = await auth.signInWithCredential(credential);
                print(data?.additionalUserInfo?.isNewUser);
              },
              child: const Text("Check"))
        ],
      ),
    );
  }
}
