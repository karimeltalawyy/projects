import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/basics/login/cubit/cubit.dart';
import 'package:test_one/modules/basics/login/cubit/states.dart';
import 'package:test_one/layout/shop_app/shop_app_layout.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';

import '../../../shared/component/constants/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccsessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(
                    context,
                    const ShopAppLayout(),
                  );
                },
              );

              //go to home screen
            } else {
              //stay here
              print(state.loginModel.message);
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
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
                          'Welcome Back! login to see new hot offers',
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
                          condition: state is! ShopLoginLoadingState,
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
                            // TextButton(
                            //   onPressed: () {},
                            //   child: const Text(
                            //     'REGISTER',
                            //   ),
                            // ),
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
