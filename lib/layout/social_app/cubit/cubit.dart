import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/modules/social_app/chats/chats_screen.dart';
import 'package:test_one/modules/social_app/new_post/new_post_screen.dart';
import 'package:test_one/modules/social_app/notifications/notification_screen.dart';
import 'package:test_one/modules/social_app/settings/settings_screen.dart';
import 'package:test_one/modules/social_app/users/users_screen.dart';
import 'package:test_one/shared/component/constants/constants.dart';

import '../../../models/social_app/social_user_model.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        //print(value.data());
        model = SocialUserModel.fromJson(value.data()!);
        emit(SocialGetUserSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(SocialGetUserErrorState(error.toString()));
      },
    );
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNavBar(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
}
