import 'package:http/http.dart' as http;
import 'dart:convert';

class TwilioService {
  final String accountSid = 'YOUR_ACCOUNT_SID'; // Replace with your Account SID
  final String authToken = 'YOUR_AUTH_TOKEN';   // Replace with your Auth Token
  final String twilioPhoneNumber = 'YOUR_TWILIO_PHONE_NUMBER'; // Replace with your Twilio phone number

  // Store OTP for verification
  String? _sentOtp;

  /// Sends an OTP to the given phone number.
  Future<bool> sendOtp(String toPhoneNumber, String otpCode) async {
    _sentOtp = otpCode; // Save the OTP locally for verification

    final String url = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';
    final String basicAuth = 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'From': twilioPhoneNumber,
        'To': toPhoneNumber,
        'Body': 'Your OTP code is $otpCode',
      },
    );

    return response.statusCode == 201;
  }

  /// Verifies the given OTP code against the stored OTP.
  bool verifyOtp(String otpCode) {
    return otpCode == _sentOtp;
  }
}
