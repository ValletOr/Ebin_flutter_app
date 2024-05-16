import 'package:enplus_market/services/apiPOST_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/services/apiPOST_otpCode.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<OTPPage> createState() => _OTPPageState();
}
class _OTPPageState extends State<OTPPage> {

  String get _number => widget.phoneNumber;
  //final _auth = FirebaseAuth.instance;
  //late String verificationCode = '';

  final _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getOTP();

    // _auth.verifyPhoneNumber(
    //   phoneNumber: _number,
    //   timeout: const Duration(seconds: 120),
    //   verificationCompleted: (credentials) async {
    //     await _auth.signInWithCredential(credentials);
    //   },
    //   verificationFailed: (exception) {},
    //   codeSent: (verificationID, [forceCodeResend]) {
    //     verificationCode = verificationID;
    //   },
    //   codeAutoRetrievalTimeout: (verificationID) {
    //     verificationCode = verificationID;
    //     _otpController.text = verificationID;
    //   },
    // );

  }

  void getOTP() async{
    ApiPOST_otpCode instance = ApiPOST_otpCode(phoneNumber: _number);
    await instance.perform();
    print(instance.message); //TODO: Это код для авторизации, я хз как нам нужно его посылать через смс, это вообще наша работа или бэка?
  }

  void login({required String otp}) async{
    ApiPOST_auth instance = ApiPOST_auth(phoneNumber: _number, otp: otp);
    try{
      await instance.perform();
    }catch (e){
      rethrow;
    }

    print(instance.message);
  }

  // Future<void> _loginWithCredentials(String otp) async {
  //   await _auth.signInWithCredential(PhoneAuthProvider.credential(
  //     verificationId: verificationCode,
  //     smsCode: otp,
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Page')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                counterText: '',
                hintText: '1234',
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(56),
                ),
              ),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  // showDialog(
                  //   context: context,
                  //   builder: (_) {
                  //     return AlertDialog(
                  //       content: Row(children: const [
                  //         CircularProgressIndicator(),
                  //         SizedBox(width: 12),
                  //         Text('Signing In'),
                  //       ]),
                  //     );
                  //   },
                  // );
                  // await _loginWithCredentials(_otpController.text);
                  // if (!mounted) return;
                  // Navigator.push(context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SecondScreen()));

                  login(otp: _otpController.text);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('$e'),
                    )
                  );
                }
              },
              child: const Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Text('Hello')
    );
  }
}