import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/basics/login/cubit/states.dart';
import 'package:test_one/modules/shop_app/signup/cubit/states.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/endpoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then(
      (value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        // print(loginModel?.data.token);
        // print(loginModel?.status);
        // print(loginModel?.message);
        emit(ShopRegisterSuccessState(loginModel!));
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopRegisterErrorState(error.toString()));
      },
    );
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;

  void changePassordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
