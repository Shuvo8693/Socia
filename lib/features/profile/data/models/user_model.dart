class UserModel {
  String userName;
  String profilePictureURL;
  String email;
  String displayName;
  String bio;
  List<dynamic> follower;
  List<dynamic> following;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({required this.bio,
      required this.displayName,
      required this.email,
      required this.profilePictureURL,
      required this.userName,
      required this.follower,
      required this.following,
      required this.createdAt,
      required this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      bio: data['Bio'],
      displayName: data['displayName'],
      email: data['email'],
      profilePictureURL: data['profilePictureURL'],
      userName: data['userName'] ,
      follower: data['Follower'] ??[],
      following: data['Following']??[],
      createdAt: (data['createdAt'] as DateTime).toUtc(),
      updatedAt: (data['updatedAt'] as DateTime).toUtc(),
    );
  }

 Map<String,dynamic> toJson() {
   Map<String, dynamic> data= {};
    data['Bio'] = bio;
    data['displayName'] = displayName;
    data['email'] = email;
    data['profilePictureURL'] = profilePictureURL;
    data['userName'] = userName;
    data['Follower'] = follower;
    data['Following'] = following;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
