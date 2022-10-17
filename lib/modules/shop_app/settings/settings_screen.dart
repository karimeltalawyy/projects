import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/shop_app/cubit/cubit.dart';
import 'package:test_one/layout/shop_app/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/component/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserDataState)
                    const LinearProgressIndicator(),
                 const SizedBox(height: 22),
                  defaultFormFeild(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    hint: 'Enter Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 12),
                  defaultFormFeild(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    hint: 'Enter Email address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(height: 12),
                  defaultFormFeild(
                    controller: phoneController,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    hint: 'Enter phone ',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(height: 32),
                  defaultButton(
                    text: 'UPDATE',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  defaultButton(
                    text: 'LOGOUT',
                    function: () {
                      signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
