import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/shop_app/login/cubit/states.dart';
import 'package:test_one/shared/network/end_point.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

   void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, query: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
