//88e3eeab017048b4b3bf830cc81ceb91
//https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY
//https://newsapi.org/v2/everything?q=tesla&from=2022-08-07&sortBy=publishedAt&apiKey=88e3eeab017048b4b3bf830cc81ceb91

//search
//https://newsapi.org/v2/everything?q=alahly&apiKey=88e3eeab017048b4b3bf830cc81ceb91
import '../../../modules/shop_app/login/shop_login.dart';
import '../../network/local/cache_helper.dart';
import '../components/components.dart';

void signOut(context) => CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

String? token = 'ENqoDRRPVeDYbJzhvGdZ6A6VSZVCCUfsRKX22RnukYqBSUgBp1UjaSozKgE4Sb3JBQfZwh';
String? uId = '';
//IrKOGX2ugrWOKSrtVgQZkMndhYIjOh7NpiZqM4U6A2IHDuVq8nnmDBnm0DQDDqE3YlECaj
//T7zeCTyHdnf2QwNKDxo73j8klVg2