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
    DataModel data = DataModel();

    data.name = mapData["name"];
    data.description = mapData["description"];
    if (type == "FOD") {
      data.phoneNumber = mapData["phone_no"];
    }

    data.location = mapData["location"];
    data.averagePrice = mapData["average_price"];
    data.rating = mapData["related_keywords"];
    data.longitude = mapData["longitude"];
    data.latitude = mapData["latitude"];
    data.imageUrls = mapData["images"];
    if (mapData["phone_no"] != null) {
      data.phoneNumber = mapData["phone_no"];
      print(phoneNumber);
    }

    return data;
  }
}
