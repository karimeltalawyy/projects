import 'package:dio/dio.dart';
import 'package:test_one/models/new_response.dart';

class NewsApiServices {
  static String _apiKey = '88e3eeab017048b4b3bf830cc81ceb91';
  String _url =
      'https://newsapi.org/v2/everything?q=tesla&from=2022-08-07&sortBy=publishedAt&apiKey=${_apiKey}';
  Dio? _dio;

  NewsApiServices() {
    _dio = Dio();
  }

  Future<List<Article> ?> fetchNewsArticle() async {
    try {
      Response response = await _dio!.get(_url);
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      return newsResponse.articles;
    } on DioError catch (error) {
      print(error);
    }
  }
}
