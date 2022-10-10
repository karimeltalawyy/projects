import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/shop_app/cubit/states.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/home_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/component/constants/constants.dart';
import '../../../shared/network/endpoints.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        print(homeModel?.status);
        printFullText(homeModel?.data.banners![0].image);

        emit(ShopSuccessHomeDataState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorHomeDataState());
      },
    );
  }
}
