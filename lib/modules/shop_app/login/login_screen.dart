import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/shop_app/login/cubit/cubit.dart';
import 'package:test_one/modules/shop_app/login/cubit/states.dart';
import 'package:test_one/modules/shop_app/register/register_screen.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/styles/colors.dart';
import 'package:test_one/shared/styles/styles.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Image(
                          image: AssetImage('assets/images/login.png'),
                          height: 250,
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        'LOGIN',
                        style: headerLogin,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Welcome Back! Login to see new hot offers.',
                        style: captionLogin,
                      ),
                      const SizedBox(height: 16),
                      defaultFormFeild(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Email Address';
                          }
                        },
                        label: 'Email address',
                        hint: 'Enter your email address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(height: 12),
                      defaultFormFeild(
                        controller: passwordController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Password';
                          }
                        },
                        label: 'Password',
                        hint: 'Enter your Password',
                        prefix: Icons.lock_outline_rounded,
                        sufix: Icons.visibility_outlined,
                        suffixPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                          text: 'Login',
                          function: () {
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text,);
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
                          const Text('Don\'t have an account yet ?'),
                          defaultTextButton(
                            text: 'Sign up',
                            function: () {
                              navigateTo(context, const RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
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
