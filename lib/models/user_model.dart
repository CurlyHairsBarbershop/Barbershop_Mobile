class UserData {
  final String name;
  final String lastName;
  final String email;
  final String phoneNumber;

  UserData({
    required this.name,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
