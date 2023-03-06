class InterestModel {
  String? name;
  int? id;
  String? type;

  InterestModel toMap(Map<String, dynamic> mapData) {
    InterestModel interest = InterestModel();

    interest.name = mapData["name"];
    interest.id = mapData["id"];
    interest.type = mapData["type"];

    return interest;
  }
}
