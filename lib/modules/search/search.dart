import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/news_app/cubit/cubit.dart';
import 'package:test_one/layout/news_app/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormFeild(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  onTap: () {
                    print('Tapped');
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  hint: 'Search something...',
                  prefix: Icons.search,
                ),
                Expanded(child: buildArticle(list, context)),
              ],
            ),
          ),
        );
      },
    );
  }
}
