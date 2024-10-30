class UserModel {
  final String email;
  final String id;
  final String? username;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': id,
      'displayName': username,
    };
  }

  UserModel.fromJSON(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'],
        username = json['username'];

  UserModel({
    required this.email,
    required this.id,
    required this.username,
  });
}
