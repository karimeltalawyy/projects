import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/news_app/cubit/cubit.dart';
import 'package:test_one/layout/news_app/cubit/states.dart';
import 'package:test_one/shared/cubit/cubit.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('News App'),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeAppMode();
                      },
                      icon: const Icon(Icons.brightness_4_outlined))
                ],
              ),
              body: cubit.screens[cubit.currentInedx],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentInedx,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: cubit.bottomItems,
              ),
            );
          }),
    );
  }
}
