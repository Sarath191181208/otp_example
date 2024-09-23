import 'package:flutter/material.dart';
import 'http_handler.dart';
import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OtpPage(),
    );
  }
}

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => OtpPageState(); // Public state class
}

class OtpPageState extends State<OtpPage> {
  // Make the state class public
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String otpStatus = '';

  final HttpHandler httpHandler = HttpHandler(AppConstants.baseUrl);

  Future<void> sendOtp() async {
    final String email = emailController.text;
    if (email.isEmpty) {
      setState(() {
        otpStatus = AppConstants.emailEmptyError;
      });
      return;
    }

    final result = await httpHandler.postRequest(
      AppConstants.sendOtpEndpoint,
      {'email': email},
    );

    result.fold(
      (response) {
        setState(() {
          otpStatus = AppConstants.otpSentSuccess;
        });
      },
      (error) {
        setState(() {
          otpStatus = error;
        });
      },
    );
  }

  Future<void> validateOtp() async {
    final String email = emailController.text;
    final String otp = otpController.text;
    if (email.isEmpty || otp.isEmpty) {
      setState(() {
        otpStatus = AppConstants.otpEmptyError;
      });
      return;
    }

    final result = await httpHandler.postRequest(
      AppConstants.validateOtpEndpoint,
      {'email': email, 'otp': otp},
    );

    result.fold(
      (response) {
        setState(() {
          otpStatus = AppConstants.otpValidationSuccess;
        });
      },
      (error) {
        setState(() {
          otpStatus = error;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: AppConstants.emailLabel,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendOtp,
              child: const Text(AppConstants.sendOtpButton),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: AppConstants.otpLabel,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: validateOtp,
              child: const Text(AppConstants.validateOtpButton),
            ),
            const SizedBox(height: 20),
            Text(
              otpStatus,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
