class UpdateUserModel {
  String bio;
  String displayName;
  String userName;

  UpdateUserModel(
      {required this.userName,
      required this.displayName,
      required this.bio,});

  Map<String, dynamic> toFireStore() {
    Map<String, dynamic> data = {};
    data['Bio'] = bio;
    data['displayName'] = displayName;
    data['userName'] = userName;

    return data;
  }
}
