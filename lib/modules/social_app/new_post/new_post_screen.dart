import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/cubit/cubit.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';

import '../../../shared/component/components/components.dart';
import '../../../shared/styles/icon/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: defaultAppBar(
              context: context,
              title: 'Create post',
              actions: [
                defaultTextButton(
                  function: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    } else {
                      SocialCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                  },
                  text: 'POST',
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/jubilant-overjoyed-african-american-woman-celebrates-victory-achieves-success-exclaims-with-tiumph-wears-sweater-tilts-head-poses-pink-wall-being-happy-winner-yeah-i-did-it_273609-42616.jpg?w=996&t=st=1667044143~exp=1667044743~hmac=5080c295999d7c1b2ae7c229ce0d3d0e9c7e6b20ed9a53e7cee799bbea73c721',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Karim Eltalawy',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind...',
                      hintStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                              ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              IconBroken.close,
                              size: 16,
                            )),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.image),
                            SizedBox(width: 8),
                            Text('Add photos'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
