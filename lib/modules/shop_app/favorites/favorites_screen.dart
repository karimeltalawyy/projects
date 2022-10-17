import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/shared/component/components/components.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../shared/styles/colors/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =ShopCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProducts(
                  ShopCubit.get(context).favoritesModel!.data!.data![index].product,
                  context),
              separatorBuilder: (context, index) => buildMyDivider(),
              itemCount:
                  ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }


}
