class User {
  final String name;
  final String email;
  final String password;
  final String photoUrl;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.photoUrl});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      photoUrl: data['photoImg'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'photoImg': photoUrl,
    };
  }
}
