class UserModel {
  final String email;
  final String id;
  final String? username;
  final List<String> liked;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': id,
      'displayName': username,
      'liked': [],
    };
  }

  UserModel.fromJSON(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'],
        liked = json['liked'].cast<String>(),
        username = json['username'];

  UserModel({
    required this.email,
    required this.id,
    required this.username,
    this.liked = const [],
  });
}
