import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_one/layout/shop_app/cubit/cubit.dart';
import 'package:test_one/layout/social_app/social_layout.dart';
import 'package:test_one/layout/todo_app/todo_layout.dart';
import 'package:test_one/modules/bmi_app/bmi/bmi_calculator.dart';
import 'package:test_one/modules/basics/counter/counter_screen.dart';
import 'package:test_one/modules/basics/login/login_screen.dart';
import 'package:test_one/modules/social_app/social_login/social_login_screen.dart';
import 'package:test_one/shared/bloc_observer.dart';
import 'package:test_one/shared/cubit/cubit.dart';
import 'package:test_one/shared/cubit/states.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';
import 'package:test_one/shared/component/constants/constants.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/shop_app/shop_app_layout.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'modules/shop_app/login/shop_login.dart';
import 'modules/shop_app/onboarding/onboarding_screen.dart';
import 'shared/styles/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  Widget? widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  // bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
  // String? token = CacheHelper.getData(key: 'token');
  // var uId = CacheHelper.getData(key: 'uId');
// var uId =CacheHelper.getData(key: 'uId');
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = const ShopAppLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = const OnBoardingScreen();
  // }
  if (uId != null) {
    widget =  SocialLayout();
  } else {
    widget = SocialAppLogin();
  }
  runApp(
    MyApp(
      isDark: isDark,
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({super.key, this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()..getUserData(),

        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            themeMode: ThemeMode.light,
            //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: SocialAppLogin(),
          );
        },
      ),
    );
  }
}
