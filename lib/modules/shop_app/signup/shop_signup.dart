import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/basics/login/cubit/cubit.dart';
import 'package:test_one/modules/basics/login/cubit/states.dart';
import 'package:test_one/layout/shop_app/shop_app_layout.dart';
import 'package:test_one/modules/shop_app/signup/cubit/cubit.dart';
import 'package:test_one/modules/shop_app/signup/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';

import '../../../shared/component/constants/constants.dart';

class ShopSignUpScreen extends StatelessWidget {
  ShopSignUpScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Welcome, Create New Account to access offers',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Satoshi medium',
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
                                ShopLoginCubit.get(context).isPasswordShown,
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
                            sufix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePassordVisibility();
                            },
                          ),
                          const SizedBox(height: 26),
                          ConditionalBuilder(
                            condition: true,
                            // state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              text: 'LOGIN',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
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
                                  fontFamily: 'Inter',
                                ),
                              ),
                              defaultTextButton(
                                function: () {},
                                text: 'REGISTER',
                              ),
                            ],
                          )
                        ],
                      ),
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
