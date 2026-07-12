import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controllers/auth_controller.dart';
import '../../network/network_caller.dart';
import '../../network/urls.dart';
import '../home/home_screen.dart';
import '../profile/create_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {

  final TextEditingController _otpTEController =
      TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {

    if (_otpTEController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter 4 digit OTP"),
        ),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    final response = await NetworkCaller.getRequest(
      Urls.verifyOtp(
        widget.email,
        _otpTEController.text,
      ),
    );

    setState(() {
      _loading = false;
    });

    if (response.isSuccess) {

      String token =
          response.responseData?["data"] ?? "";

      await AuthController.saveUserToken(token);

      final profileResponse =
          await NetworkCaller.getRequest(
        Urls.readProfile,
      );

      if (!mounted) return;

      if (profileResponse.isSuccess) {

        final profile =
            profileResponse.responseData?["data"];

        if (profile is List && profile.isNotEmpty) {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
            (_) => false,
          );

        } else {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const CreateProfileScreen(),
            ),
            (_) => false,
          );

        }

      } else {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const CreateProfileScreen(),
          ),
          (_) => false,
        );

      }

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.errorMessage ??
                "OTP Verification Failed",
          ),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 30),

            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            PinCodeTextField(
              appContext: context,

              controller: _otpTEController,

              length: 4,

              keyboardType:
                  TextInputType.number,

              animationType:
                  AnimationType.fade,

              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius:
                    BorderRadius.circular(10),
                fieldHeight: 55,
                fieldWidth: 55,
                activeFillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                onPressed:
                    _loading ? null : _verifyOTP,

                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: 17,
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
