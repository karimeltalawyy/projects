import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/basics/login/cubit/states.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        // print(loginModel?.data.token);
        // print(loginModel?.status);
        // print(loginModel?.message);
        emit(
          ShopLoginSuccessState(loginModel!),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(
          ShopLoginErrorState(error.toString()),
        );
      },
    );
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;

  void changePassordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
