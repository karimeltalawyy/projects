import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/social_app/social_login/cubit/cubit.dart';
import 'package:test_one/modules/social_app/social_signup/social_signup.dart';

import '../../../shared/component/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../shop_app/signup/shop_signup.dart';
import '../social_signup/cubit/states.dart';
import 'cubit/states.dart';

class SocialAppLogin extends StatelessWidget {
  SocialAppLogin({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Welcome Back! login to fast communicate',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 46),
                        defaultFormFeild(
                          onTap: () {
                            print('Email entered');
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'You must add email address';
                            }
                          },
                          label: 'Email Address',
                          hint: 'Enter email address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 16),
                        defaultFormFeild(
                          onTap: () {
                            print('password entered');
                          },
                          isPassword:
                              SocialLoginCubit.get(context).isPasswordShown,
                          controller: passwordController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'You must add correct password';
                            }
                          },
                          label: 'Password',
                          hint: 'Enter your password',
                          prefix: Icons.lock_outline_rounded,
                          sufix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(height: 26),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: 'LOGIN',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account yet?',
                              style: TextStyle(
                                fontFamily: 'Satoshi medium',
                              ),
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, SocialSignUpScreen());
                              },
                              text: 'SIGN UP',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
