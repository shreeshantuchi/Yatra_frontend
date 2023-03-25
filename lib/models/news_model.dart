import 'package:yatra/models/list_abstract_class.dart';

class NewsModel {
  int? id;
  String? topic;
  String? sourceName;
  String? sourceLink;
  String? imgUrl;
  String? date;

  NewsModel toMap(Map<String, dynamic> mapData) {
    NewsModel data = NewsModel();

    data.id = mapData["id"];
    data.topic = mapData["topic"];
    data.date = mapData["date"];
    data.sourceLink = mapData["source_link"];
    data.sourceName = mapData["source_name"];
    data.imgUrl = mapData["image_url"];

    return data;
  }
}
