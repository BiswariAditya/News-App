
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/categoryNewsModels.dart';
import 'package:news_app/Models/headlineModels.dart';
class NewsRepository{
  Future<headlineModels> fetchNewsApi() async{
    String url= 'https://newsapi.org/v2/top-headlines?country=in&apiKey=cc500e95869b463b84b1c95765b88161';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final body= jsonDecode(response.body);
      return headlineModels.fromJson(body);
    }throw Exception('error');
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    String url= 'https://newsapi.org/v2/everything?q=${category}&apiKey=cc500e95869b463b84b1c95765b88161';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final body= jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }throw Exception('error');
  }
}