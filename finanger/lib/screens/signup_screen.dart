import 'package:finanger/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/widgets/text_field_input.dart';
import '/widgets/bottom_nav_bar.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void signup() {
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
              height: 100,
            ),
            const SizedBox(height: 64),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
            const SizedBox(height: 40),
            // Text Field for Name
            TextFieldInput(
              hintText: 'Name',
              textEditingController: _nameController,
              textInputType: TextInputType.text,
              icon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 24),
            // Text Field for Email
            TextFieldInput(
              hintText: 'Email',
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              icon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 24),
            // Text Field for Password
            TextFieldInput(
              hintText: 'Password',
              textEditingController: _passwordController,
              isPass: true,
              textInputType: TextInputType.visiblePassword,
              icon: const Icon(Icons.lock_outline),
            ),
            const SizedBox(height: 30),
            // Sign Up Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoadingButton(
                    displayText: 'Sign up',
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: signup)
              ],
            ),
            const SizedBox(height: 20),
            // Transition to Login
            Flexible(flex: 1, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Already have an account?",
                  ),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: Text(
                      "Login",
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
