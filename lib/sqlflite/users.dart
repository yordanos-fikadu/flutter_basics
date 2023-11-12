class Users {
  final int id;
  final String name;
  final String email;
  const Users({
    required this.id,
    required this.name,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

 static Users fromMap(Map<String, dynamic> map) {
    return Users(id: map['id'], name: map['name'], email: map['email']);
  }
}
