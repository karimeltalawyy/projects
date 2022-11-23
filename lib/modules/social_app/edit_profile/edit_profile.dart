import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_one/layout/social_app/cubit/cubit.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';

import '../../../shared/styles/icon/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  text: 'UPDATE',
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserLoadingErrorState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.camera,
                                      size: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 54,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.camera,
                                      size: 16,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(children: [
                      if (SocialCubit.get(context).profileImage != null)
                        Expanded(
                            child: Column(
                          children: [
                            defaultButton(
                              text: 'Update profile',
                              function: () {
                                SocialCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            const LinearProgressIndicator(),
                          ],
                        )),
                      const SizedBox(width: 12),
                      if (SocialCubit.get(context).coverImage != null)
                        Expanded(
                            child: Column(
                          children: [
                            defaultButton(
                                text: 'Update cover', function: () {
                              SocialCubit.get(context).uploadCoverImage(
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                              );
                            },),
                            if(state is SocialUserUpdateLoadingState)
                            const LinearProgressIndicator(),
                          ],
                        )),
                    ]),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(height: 26),
                  defaultFormFeild(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'value must not be empty';
                      }
                    },
                    label: 'Edit name',
                    hint: 'Edit name',
                    prefix: IconBroken.person,
                  ),
                  const SizedBox(height: 16),
                  defaultFormFeild(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                    },
                    label: 'Edit bio',
                    hint: 'Edit bio',
                    prefix: IconBroken.infoCircle,
                  ),
                  const SizedBox(height: 16),
                  defaultFormFeild(
                    controller: phoneController,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                    },
                    label: 'Edit phone',
                    hint: 'Edit phone',
                    prefix: IconBroken.call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
