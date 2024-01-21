import 'package:news_app/Models/categoryNewsModels.dart';
import 'package:news_app/Repositories/newsRepo.dart';
import '../Models/headlineModels.dart';

class NewsViewModel {
  final NewsRepository repo = NewsRepository();

  Future<headlineModels> fetchNewsApi() async {
    try {
      final response = await repo.fetchNewsApi();
      return response;
    } catch (e) {
      // Handle the error, you might want to log it or return a custom error response.
      print('Error fetching news: $e');
      throw Exception('Failed to fetch news');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    try {
      final response = await repo.fetchCategoriesNewsApi(category);
      return response;
    } catch (e) {
      // Handle the error, you might want to log it or return a custom error response.
      print('Error fetching category news: $e');
      throw Exception('Failed to fetch category news');
    }
  }
}
