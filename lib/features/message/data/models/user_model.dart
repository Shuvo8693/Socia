class User {
  String userName;
  String profilePictureURL;
  String email;
  String displayName;
  String bio;

  User(
      {required this.bio,
      required this.displayName,
      required this.email,
      required this.profilePictureURL,
      required this.userName});
}
