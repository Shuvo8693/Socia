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
   bio.isNotEmpty? data['Bio'] = bio: null;
   displayName.isNotEmpty? data['displayName'] = displayName : null;
   userName.isNotEmpty? data['userName'] = userName : null;
    return data;
  }
}
