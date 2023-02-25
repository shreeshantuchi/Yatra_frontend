class UserProfile {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? profileImage;

  UserProfile toMap(Map<String, dynamic> mapData) {
    UserProfile user = UserProfile();
    print(mapData);
    user.phoneNumber = mapData["phone_no"];
    user.firstName = mapData["first_name"];
    user.lastName = mapData["last_name"];
    user.email = mapData["email"];
    user.profileImage = mapData["profile_image"];

    return user;
  }
}
