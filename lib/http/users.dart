class Users {
  final int id;
  final String name;
  final String username;
  final String email;
  const Users({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }

  factory Users.fromjson(Map<String, dynamic> json) {
    return Users(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email']);
  }
}
