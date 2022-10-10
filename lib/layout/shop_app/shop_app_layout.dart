import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/shop_app/cubit/cubit.dart';
import 'package:test_one/layout/shop_app/cubit/states.dart';
import 'package:test_one/modules/shop_app/login/shop_login.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/search/search_screen.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('SHOPly'),
            actions:  [
              IconButton(onPressed: (){
                navigateTo(context, const SearchScreen());
              }, icon:const Icon(Icons.search)),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.grid_4x4_outlined), label: 'Category'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
