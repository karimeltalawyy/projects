import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/models/social_app/social_user_model.dart';
import 'package:test_one/modules/basics/login/cubit/states.dart';
import 'package:test_one/modules/shop_app/signup/cubit/states.dart';
import 'package:test_one/modules/social_app/social_signup/cubit/states.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/endpoints.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUsers(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUsers({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      bio: 'Write Bio about yourself..',
      image:
          'https://img.freepik.com/free-psd/3d-cartoon-man-carrying-lot-books_1150-56198.jpg?w=1060&t=st=1667063662~exp=1667064262~hmac=44eca54481353572974d3b6fc536bff83954f873b0115466665e2cc17c52f557',
      cover:
          'https://img.freepik.com/free-psd/3d-cartoon-man-carrying-lot-books_1150-56198.jpg?w=1060&t=st=1667063662~exp=1667064262~hmac=44eca54481353572974d3b6fc536bff83954f873b0115466665e2cc17c52f557',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;

  void changePassordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
