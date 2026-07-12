import 'dart:async';

import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../auth/email_verification_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveNext();
  }

  Future<void> _moveNext() async {

    await AuthController.loadUserToken();

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    if (AuthController.isLoggedIn) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const EmailVerificationScreen(),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.shopping_bag,
              size: 100,
              color: Colors.green,
            ),

            SizedBox(height: 20),

            Text(
              "CraftyBay",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            SizedBox(height: 40),

            CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}
