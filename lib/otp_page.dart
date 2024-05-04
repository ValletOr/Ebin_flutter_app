import 'package:flutter/material.dart';
class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<OTPPage> createState() => _OTPPageState();
}
class _OTPPageState extends State<OTPPage> {
  String get _number => widget.phoneNumber;
  late String verificationCode = '';
  final _otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
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
              maxLength: 6,
              decoration: const InputDecoration(
                counterText: '',
                hintText: '12345',
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
                try {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Row(children: const [
                          CircularProgressIndicator(),
                          SizedBox(width: 12),
                          Text('Signing In'),
                        ]),
                      );
                    },
                  );
                  if (!mounted) return;
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => SecondScreen()));
                } catch (_) {
                  print('Exception - $_');
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
    return Scaffold(
      appBar: AppBar(title: const Text('Market')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: '12345',
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Icon(Icons.account_circle_sharp)
              ],
            ),
            SingleChildScrollView(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.map),
                    title: Text('Map'),
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text('Album'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),);
  }
}