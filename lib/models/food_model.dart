import 'package:yatra/models/list_abstract_class.dart';

class DataModel {
  int? id;
  String? name;
  String? description;
  String? phoneNumber;
  String? location;
  String? averagePrice;
  String? longitude;
  String? latitude;
  String? rating;
  List? imageUrls;
  String? type;

  DataModel toMap(Map<String, dynamic> mapData, String type) {
    DataModel food = DataModel();

    food.name = mapData["name"];
    food.description = mapData["description"];
    if (type == "FOD") {
      food.phoneNumber = mapData["phone_no"];
    }

    food.location = mapData["location"];
    food.averagePrice = mapData["average_price"];
    food.rating = mapData["related_keywords"];
    food.longitude = mapData["longitude"];
    food.latitude = mapData["latitude"];
    food.imageUrls = mapData["images"];

    return food;
  }
}
