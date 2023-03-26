import 'package:yatra/models/list_abstract_class.dart';

class ActivityModel {
  int? id;
  String? name;
  String? description;
  String? phoneNumber;
  String? location;
  String? averagePrice;
  String? type;
  String? latitude;
  String? longitude;
  String? rating;
  List? imageUrls;

  ActivityModel toMap(Map<String, dynamic> mapData) {
    ActivityModel data = ActivityModel();

    data.name = mapData["name"];
    data.description = mapData["description"];

    data.location = mapData["location"];
    data.averagePrice = mapData["average_price"];
    data.rating = mapData["related_keywords"];
    data.longitude = mapData["longitude"];
    data.latitude = mapData["latitude"];
    data.imageUrls = mapData["images"];
    if (mapData["phone_no"] != null) {
      data.phoneNumber = mapData["phone_no"];
      print(phoneNumber);
    } else {
      data.phoneNumber = null;
    }

    return data;
  }
}
