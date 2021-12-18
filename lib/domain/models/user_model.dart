class UserModel {
  String? id;
  String userName;
  String email;
  String password;
  String avatarLink;

  UserModel(
      // constructor del modelo
      {
    this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.avatarLink,
  });
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'avatarLink': avatarLink,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      id: map?['id'],
      userName: map?['userName'],
      email: map?['email'],
      password: map?['password'],
      avatarLink: map?['avatarLink'],
    );
  }
}
