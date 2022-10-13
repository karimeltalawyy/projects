import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/shop_app/cubit/states.dart';
import 'package:test_one/models/shop_app/home_model.dart';
import 'package:test_one/modules/shop_app/favorites/favorites_screen.dart';
import 'package:test_one/modules/shop_app/products/products_screen.dart';
import 'package:test_one/modules/shop_app/settings/settings_screen.dart';
import 'package:test_one/shared/component/constants/constants.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../shared/network/endpoints.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites!.addAll({
          element.id!: element.inFavorite!,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId) {
    favorites![productId!] = !favorites![productId]!;

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then(
      (value) {
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        print(value.data);
        if (!changeFavoritesModel!.status!) {
          favorites![productId] = !favorites![productId]!;
        }else{
          getFavorites();
        }
        emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
      },
    ).catchError(
      (error) {
        favorites![productId] = !favorites![productId]!;
        emit(ShopErrorChangeFavoritesState());
      },
    );
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then(
      (value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        print(value.data.toString());
        emit(ShopSuccessGetFavoritesState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorGetFavoritesState());
      },
    );
  }
}
