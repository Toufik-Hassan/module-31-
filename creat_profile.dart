import 'package:flutter/material.dart';

import '../../network/network_caller.dart';
import '../../network/urls.dart';
import '../home/home_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState
    extends State<CreateProfileScreen> {

  final TextEditingController firstNameTEController =
      TextEditingController();

  final TextEditingController lastNameTEController =
      TextEditingController();

  final TextEditingController mobileTEController =
      TextEditingController();

  final TextEditingController cityTEController =
      TextEditingController();

  final TextEditingController addressTEController =
      TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    firstNameTEController.dispose();
    lastNameTEController.dispose();
    mobileTEController.dispose();
    cityTEController.dispose();
    addressTEController.dispose();
    super.dispose();
  }

  Future<void> createProfile() async {
    if (firstNameTEController.text.trim().isEmpty ||
        lastNameTEController.text.trim().isEmpty ||
        mobileTEController.text.trim().isEmpty ||
        cityTEController.text.trim().isEmpty ||
        addressTEController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required"),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    final response = await NetworkCaller.postRequest(
      Urls.createProfile,
      {
        "firstName": firstNameTEController.text.trim(),
        "lastName": lastNameTEController.text.trim(),
        "mobile": mobileTEController.text.trim(),
        "city": cityTEController.text.trim(),
        "shippingAddress":
            addressTEController.text.trim(),
      },
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (response.isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
        (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.errorMessage ?? "Profile Creation Failed",
          ),
        ),
      );
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            buildTextField(
              controller: firstNameTEController,
              hint: "First Name",
            ),

            buildTextField(
              controller: lastNameTEController,
              hint: "Last Name",
            ),

            buildTextField(
              controller: mobileTEController,
              hint: "Mobile",
              keyboardType: TextInputType.phone,
            ),

            buildTextField(
              controller: cityTEController,
              hint: "City",
            ),

            buildTextField(
              controller: addressTEController,
              hint: "Shipping Address",
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    loading ? null : createProfile,
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Complete",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
