class UserModel {
  final String email;
  final String password;
  final String name;
  

  UserModel({
    required this.email,
    required this.password,
    required this.name,

  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password, 'name': name};
  }
}
