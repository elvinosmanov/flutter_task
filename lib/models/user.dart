class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarURL;
  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatarURL': avatarURL,
    };
  }

  factory UserModel.fromJson(Map map) {
    return UserModel(
      id: map['id'] ?? 0,
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      avatarURL: map['avatar'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatarURL: $avatarURL)';
  }
}
