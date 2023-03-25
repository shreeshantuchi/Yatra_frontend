import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yatra/models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewsApi extends ChangeNotifier {
  List<NewsModel> newsList = [];
  Future<List<NewsModel>> getNewsList() async {
    NewsModel newsModel = NewsModel();
    String interestUrl = "http://10.0.2.2:8000/api/newsandinfo/news/list/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        newsModel = newsModel.toMap(data[i]);
        newsList.add(newsModel);
      }
    }
    return newsList;
  }
}
