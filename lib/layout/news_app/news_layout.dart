import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/news_app/cubit/cubit.dart';
import 'package:test_one/layout/news_app/cubit/states.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('News App'),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
              body: cubit.screens[cubit.currentInedx],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  DioHelper.getData(
                    url: 'v2/everything',
                    query: {
                      'q': 'tesla',
                      'from': '2022-08-07',
                      'sortBy': 'publishedAt',
                      'apiKey': '88e3eeab017048b4b3bf830cc81ceb91'
                    },
                  ).then((value) {
                    print(value.data['totalResults']);
                  }).catchError((error) {
                    print(error.toString());
                  });
                },
                child: const Icon(Icons.add),
              ),
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
