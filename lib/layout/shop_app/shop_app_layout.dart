import 'package:flutter/material.dart';
import 'package:test_one/modules/shop_app/login/shop_login.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SALLA'),
      ),
      body: Center(
        child: defaultTextButton(
            function: () {
              CacheHelper.removeData(key: 'token').then((value) {
                if (value) {
                  navigateAndFinish(context, ShopLoginScreen());
                }
              });
            },
            text: 'Sign Out'),
      ),
    );
  }
}
