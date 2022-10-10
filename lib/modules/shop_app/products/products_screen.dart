import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/shop_app/cubit/cubit.dart';
import 'package:test_one/layout/shop_app/cubit/states.dart';

import '../../../models/shop_app/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) =>
              productBuilder(ShopCubit.get(context).homeModel),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model) => Column(
        children: [
          CarouselSlider(
            items: model!.data.banners
                ?.map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                model.data.products!.length,
                (index) => buildGridProduct(model.data.products![index]),
              ),
            ),
          ),
        ],
      );
  Widget buildGridProduct(ProductsModel model) => Column(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      );
}
