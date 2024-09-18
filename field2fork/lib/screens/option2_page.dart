import 'package:flutter/material.dart';
import 'farmer_dashboard_page.dart'; // Ensure this file contains FarmerDashboardPage

class Option2Page extends StatefulWidget {
  const Option2Page({super.key});

  @override
  _Option2PageState createState() => _Option2PageState();
}

class _Option2PageState extends State<Option2Page> with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;
  final String _staticPhoneNumber = '1234567890'; // Static phone number for demo
  final String _staticOtp = '123456'; // Static OTP for demo
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _phoneFormKey = GlobalKey<FormState>(); // Key to manage phone number form
  final _otpFormKey = GlobalKey<FormState>(); // Key to manage OTP form

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _sendOtp() async {
    if (_phoneFormKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate sending OTP
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isOtpSent = true;
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OTP Sent'),
          content: Text('An OTP has been sent to $_staticPhoneNumber'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _verifyOtp() {
    if (_otpFormKey.currentState?.validate() ?? false) {
      final otpCode = _otpController.text.trim();

      if (otpCode == _staticOtp) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FarmerDashboardPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Verification Failed'),
            content: const Text('Invalid OTP. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In as Farmer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1 + 0.05 * _animation.value,
                child: child,
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isOtpSent) ...[
                  Form(
                    key: _phoneFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            // Optionally, add a regex for phone number validation
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _sendOtp,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Send OTP'),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Form(
                    key: _otpFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(labelText: 'Enter OTP'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _verifyOtp,
                          child: const Text('Verify OTP'),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
