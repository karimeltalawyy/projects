import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/cubit/cubit.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';

import '../../modules/social_app/new_post/new_post_screen.dart';
import '../../shared/styles/icon/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState)
          {
            navigateTo(context, const NewPostScreen());
          }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.notifications)),
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.chatCircle), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.paperUpload), label: 'Add Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
