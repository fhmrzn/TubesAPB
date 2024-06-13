import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pangyangjourney/features/feature/screens/home/home.dart';

import '../../../../../../../navbar.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/constants/text_strings.dart';
import '../../../password_configuration/forget_password.dart';
import '../../../signup/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginForm();
  }
}

typedef OnLoginSuccess = void Function(String username);

class LoginForm extends StatefulWidget {
  final OnLoginSuccess onLoginSuccess;

  const LoginForm({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _login() async {
    try {
      if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter both username and password')),
          );
          return;
      }

      QuerySnapshot userSnapshot = await _firestore
          .collection('user')
          .where('username', isEqualTo: _usernameController.text.trim())
          .where('password', isEqualTo: _passwordController.text.trim())
          .get();


      if (userSnapshot.docs.isNotEmpty) {
        widget.onLoginSuccess(_usernameController.text.trim());
        // Navigate to home or any other screen after successful login
      }

      if (userSnapshot.docs.isNotEmpty) {
        Navigator.pushReplacement(context, 
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: _usernameController.text.trim())),
          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occured'))
      );
    }
  }

   Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections,),
        child: Column(
          children: [
            ///Email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///Password
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash)
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            ///Remember Me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value){}),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                ///Forget Password
                TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgetPassword),)
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///Sign in Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const NavigationMenu()), child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems,),

            ///Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}