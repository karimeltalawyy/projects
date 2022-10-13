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
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context).favoritesModel!.data!.data![index],
                context),
            separatorBuilder: (context, index) => buildMyDivider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      '${model.product!.image}',
                    ),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontFamily: 'Satoshi medium',
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22.0,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: defaultColor,
                            fontFamily: 'Satoshi medium',
                            // fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (model.product!.discount != 0)
                          Text(
                            model.product!.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id);
                          },
                          icon: const CircleAvatar(
                            // backgroundColor: ShopCubit.get(context).favorites![model.product!.id]! ? defaultColor : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
