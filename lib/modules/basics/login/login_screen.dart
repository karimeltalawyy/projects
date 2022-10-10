import 'package:flutter/material.dart';
import 'package:test_one/shared/component/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isPasswordShow = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 40),
                    defaultFormFeild(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                      },
                      label: 'Email Address',
                      hint: 'Email',
                      prefix: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    defaultFormFeild(
                      isPassword: isPasswordShow,
                      controller: passwordController,
                      type: TextInputType.number,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Password must not be empty';
                        }
                      },
                      label: 'Password',
                      hint: 'Enter password',
                      prefix: Icons.lock,
                      sufix: isPasswordShow
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    defaultButton(
                      text: 'Login',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    defaultButton(
                      // radius: 12,
                      text: 'Signup',
                      function: () {
                        print(emailController.text);
                        print(passwordController.text);
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Sign up'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
