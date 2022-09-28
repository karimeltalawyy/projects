import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/news_app/cubit/cubit.dart';
import 'package:test_one/layout/news_app/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context, state) {
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormFeild(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  hint: 'Search something',
                  prefix: Icons.search,
                ),
                Expanded(child: articleBuilderItem(list, context)),
              ],
            ),
          ),
        );
      },

    );
  }
}
