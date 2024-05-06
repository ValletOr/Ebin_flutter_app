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
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final List<Widget> _widget = List.generate(2,
            (index) => Container(
              child: Text("Hello is $index"),
            ));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    height: 50.0,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        contentPadding: EdgeInsets.all(10.0),
                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        // Add a search icon or button to the search bar
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46.0),
                        ),
                      ),),
                  ),
                ),
                const Icon(Icons.account_circle_sharp),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    children: _widget.map(
                            (e) => ExpansionPanelRadio(
                            value: e,
                            headerBuilder: (BuildContext context, bool isExpanded)=>ListTile(
                              title: Text("My title"),
                            ),
                            body: e
                        )).toList(),
                  ),
                )
            ),
          ],
        ),
      ),);
  }
}