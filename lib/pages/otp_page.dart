import 'package:enplus_market/providers/user_provider.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String get _number => widget.phoneNumber;
  final _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  void _sendOtp() async {

    final apiService = ApiService();

    try {
      final response = await apiService.sendOtp(_number);
      final otp = response["message"];
      String _good = "OTP received: $otp";
      print(_good);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_good, style: const TextStyle(fontSize: 24)),
        ),
      );
    } catch (e) {
      String _err = "Error sending OTP: $e";
      print(_err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_err, style: const TextStyle(fontSize: 24)),
        ),
      );
    }//TODO: Figure out how to send OTP via SMS
  }

  void login({required String otp}) async {
    setState(() {
      _isLoading = true;
    });

    final apiService = ApiService();

    try {
      await apiService.authenticate(_number, otp);

      if (mounted) {
        await context.read<UserProvider>().getAccount();
      }

      if (mounted) {
        context.go('/main');
      }

    } catch (e) {
      String _err = "Login error: $e";
      print(_err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_err, style: const TextStyle(fontSize: 24)),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
              onPressed: _isLoading ? null : () async {
                FocusManager.instance.primaryFocus?.unfocus();
                login(otp: _otpController.text);
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign in'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final apiSerice = ApiService();
          apiSerice.logout();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}