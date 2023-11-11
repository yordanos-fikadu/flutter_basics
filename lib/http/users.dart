class Users {
  int id;
  String name;
  String username;
  String email;
  Users({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email']);
  }
}
