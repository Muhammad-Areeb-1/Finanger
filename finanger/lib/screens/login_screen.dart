import 'package:finanger/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/widgets/text_field_input.dart';
import '/widgets/bottom_nav_bar.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToSignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  void login() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 1, child: Container()),
            SvgPicture.asset(
              'assets/logo.svg',
              height: 90,
            ),
            const SizedBox(height: 45),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Please sign in to continue.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    )),
              ],
            ),
            const SizedBox(height: 40),
            // Text Field for Email
            TextFieldInput(
              hintText: 'Enter your email',
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              icon: const Icon(Icons.email),
            ),
            const SizedBox(height: 24),
            // Text Field for Password
            TextFieldInput(
              hintText: 'Enter your password',
              textEditingController: _passwordController,
              isPass: true,
              textInputType: TextInputType.visiblePassword,
              icon: const Icon(Icons.lock),
            ),
            const SizedBox(height: 24),
            // Sign Up Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoadingButton(
                    displayText: 'Login',
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: login)
              ],
            ),
            const SizedBox(height: 12),
            Flexible(flex: 1, child: Container()),
            // Transition to Signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Don't have an account?",
                  ),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      )),
    );
  }
}
