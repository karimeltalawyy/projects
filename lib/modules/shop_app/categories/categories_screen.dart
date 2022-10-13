import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/shop_app/cubit/cubit.dart';
import 'package:test_one/layout/shop_app/cubit/states.dart';
import 'package:test_one/models/shop_app/categories_model.dart';
import 'package:test_one/shared/component/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => buildMyDivider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length,
          ),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Text(
              '${model.name}',
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
      );
}
