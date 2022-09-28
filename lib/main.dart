import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_one/bloc_observer.dart';
import 'package:test_one/layout/news_app/cubit/cubit.dart';
import 'package:test_one/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:test_one/shared/cubit/cubit.dart';
import 'package:test_one/shared/cubit/state.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';
import 'package:test_one/shared/styles/themes.dart';

import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp(this.isDark, {super.key});

  // final bool isDark;
  // const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSport()
            ..getScience(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:  const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
