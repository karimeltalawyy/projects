import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/modules/social_app/chats/chats_screen.dart';
import 'package:test_one/modules/social_app/new_post/new_post_screen.dart';
import 'package:test_one/modules/social_app/notifications/notification_screen.dart';
import 'package:test_one/modules/social_app/settings/settings_screen.dart';
import 'package:test_one/modules/social_app/users/users_screen.dart';
import 'package:test_one/shared/component/constants/constants.dart';

import '../../../models/social_app/post_model.dart';
import '../../../models/social_app/social_user_model.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    NewPostScreen(),
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

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
        // profileImageUrl = value;
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        // coverImageUrl = value;
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserLoadingErrorState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   }
  //   else if (coverImage != null && profileImage != null){
  //
  //   }
  //   else {
  //     updateUser(
  //       phone:phone ,
  //       name: name,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel userModel = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: model!.uId,
      image: image ?? model!.image,
      email: model!.email,
      cover: cover ?? model!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String? postImage,
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel userModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance.collection('posts').add(userModel!.toMap()).then(
      (value) {
        emit(SocialCreatePostSuccessState());
      },
    ).catchError(
      (error) {
        emit(SocialCreatePostErrorState());
      },
    );
  }

  List<PostModel>? posts = [];
  List<String>? postId = [];
  List<int>? likes = [];
  List<int>? comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then(
      (value) {
        value.docs.forEach((element) {
          element.reference.collection('likes').get().then((value) {
            likes!.add(value.docs.length);
            postId!.add(element.id);
            posts!.add(PostModel.fromJson(element.data()));
          }).catchError((error) {});
          element.reference.collection('comments').get().then((value) {
            comments!.add(value.docs.length);
          }).catchError((error) {
            print(error.toString());
          });
        });
        emit(SocialGetPostSuccessState());
      },
    ).catchError(
      (error) {
        emit(SocialGetPostErrorState(error.toString()));
      },
    );
  }

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialPostLikesSuccessState());
    }).catchError((error) {
      emit(SocialPostLikesErrorState(error.toString()));
    });
  }

  void commentPost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set(
      {'comments': true},
    ).then((value) {
      emit(SocialPostCommentsSuccessState());
    }).catchError((error) {
      emit(SocialPostCommentErrorState(error.toString()));
    });
  }
}
