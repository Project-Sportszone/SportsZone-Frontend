class UserModel {
  final String name;
  final String email;
  final String password;
  final String location;
  final String dateOfBirth;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "location": location,
      "dateOfBirth": dateOfBirth,
    };
  }
}
