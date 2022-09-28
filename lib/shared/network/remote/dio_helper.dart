import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          connectTimeout: 20 * 1000,
          receiveTimeout: 20 * 1000,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang': 'en',
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> query,
}){
    return  dio.post(url,queryParameters: query);
  }
}
