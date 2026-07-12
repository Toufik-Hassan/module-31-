import 'package:flutter/material.dart';

import '../../network/network_caller.dart';
import '../../network/urls.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationScreen> {

  final TextEditingController _emailTEController =
      TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  Future<void> _verifyEmail() async {

    if (_emailTEController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter Email"),
        ),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    final response = await NetworkCaller.getRequest(
      Urls.userLogin(
        _emailTEController.text.trim(),
      ),
    );

    setState(() {
      _loading = false;
    });

    if (response.isSuccess) {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            email: _emailTEController.text.trim(),
          ),
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.errorMessage ?? "Request Failed",
          ),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Email Verification"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 40),

            TextField(
              controller: _emailTEController,

              keyboardType: TextInputType.emailAddress,

              decoration: InputDecoration(
                labelText: "Email",

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                onPressed:
                    _loading ? null : _verifyEmail,

                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
