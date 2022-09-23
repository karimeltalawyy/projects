import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org',
        connectTimeout: 20*1000,
        receiveTimeout: 20*1000,
        receiveDataWhenStatusError: true,

      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
  })async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
//https://newsapi.org/
// v2/everything?
// q=apple&from=2022-09-06&to=2022-09-06&sortBy=popularity&apiKey=88e3eeab017048b4b3bf830cc81ceb91
