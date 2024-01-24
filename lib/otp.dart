import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otpCode = '';

  @override
  void initState() {
    super.initState();
    startListeningForOTP();
  }

  void startListeningForOTP() async {
    // Start listening for incoming SMS messages
    await SmsAutoVerify.start();

    // Subscribe to the SMS code received event
    SmsAutoVerify.addListener((message) {
      String code = _extractOTPCode(message);
      setState(() {
        otpCode = code;
      });
    });
  }

  String _extractOTPCode(String message) {
    // Extract the OTP code from the received SMS message
    // The extraction logic may vary depending on the SMS format you're expecting
    RegExp regExp = RegExp(r'\b(\d{6})\b');
    Match match = regExp.firstMatch(message);
    return match?.group(0) ?? '';
  }

  @override
  void dispose() {
    // Stop listening for SMS messages when the widget is disposed
    SmsAutoVerify.removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
      ),
      body: Center(
        child: Text(
          'OTP Code: $otpCode',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}