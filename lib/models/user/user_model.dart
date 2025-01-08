class UserModel {
  final String email;
  final String id;
  final String? username;
  final List<String> liked;
  final String type;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': id,
      'displayName': username,
      'liked': [],
      'type': type,
    };
  }

  UserModel.fromJSON(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'],
        liked = json['liked'].cast<String>(),
        type = json['type'] ?? 'Streamer',
        username = json['username'];

  UserModel({
    required this.email,
    required this.id,
    required this.username,
    this.liked = const [],
    this.type = 'Streamer',
  });
}
