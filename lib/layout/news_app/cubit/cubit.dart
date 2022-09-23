import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/news_app/cubit/states.dart';
import 'package:test_one/modules/business/business_screen.dart';
import 'package:test_one/modules/science/science_screen.dart';
import 'package:test_one/modules/settings/settings_screen.dart';
import 'package:test_one/modules/sports/sport_screen.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sport'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = const [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingScreen()
  ];

  void changeBottomNavBar(int index) {
    if (index == 1) {
      getSport();
    }
    if (index == 2) {
      getScience();
    }
    currentIndex = index;
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingBusinessState());
    DioHelper.getData(
      url: '/v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '88e3eeab017048b4b3bf830cc81ceb91'
      },
    ).then(
      (value) {
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      },
    );
  }

  List<dynamic> sport = [];

  void getSport() {
    emit(NewsLoadingSportState());
    DioHelper.getData(
      url: '/v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sport',
        'apiKey': '88e3eeab017048b4b3bf830cc81ceb91'
      },
    ).then(
      (value) {
        sport = value.data['articles'];
        print(sport[0]['title']);
        emit(NewsGetBusinessSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(NewsGetSportErrorsState(error.toString()));
      },
    );
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsLoadingBusinessState());
    DioHelper.getData(
      url: '/v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '88e3eeab017048b4b3bf830cc81ceb91'
      },
    ).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorsState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String? value) {
    emit(NewsLoadingSearchState());
    DioHelper.getData(
      url: '/v2/everything',
      query: {'q': '$value', 'apiKey': '88e3eeab017048b4b3bf830cc81ceb91'},
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorsState(error.toString()));
    });
  }
}
