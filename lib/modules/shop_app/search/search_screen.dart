import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/shop_app/search/cubit/cubit.dart';
import 'package:test_one/modules/shop_app/search/cubit/states.dart';
import 'package:test_one/shared/component/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormFeild(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'search Must not be empty';
                          }
                        },
                        label: 'Search',
                        hint: 'Search something....',
                        prefix: Icons.search,
                        onSubmit: (String? text) {
                          SearchCubit.get(context).search(text);
                        }),
                    const SizedBox(height: 12),
                    defaultButton(text: 'Search', function: (String? text){
                      SearchCubit.get(context).search(text);
                    }),
                    const SizedBox(height: 22),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 22),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProducts(SearchCubit.get(context).searchModel!.data!.data![index],context),
                        separatorBuilder: (context, index) => buildMyDivider(),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
