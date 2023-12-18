import 'package:curly_hairs/models/user_model.dart';
import 'package:curly_hairs/models/review_model.dart';

class Barber extends UserData {
  final int id;
  final double earnings;
  final double rating;
  final String image;
  final List<Review> reviews;

  Barber({
    required this.id,
    required String name,
    required String lastName,
    required String email,
    required String phoneNumber,
    required this.earnings,
    required this.rating,
    required this.image,
    required this.reviews,
  }) : super(
          name: name,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
        );

  factory Barber.fromJson(Map<String, dynamic> json) {
    print(json);
    Map<String, dynamic> newJson = {};
    json.forEach((key, value) {
    String lowerCaseKey = key.toLowerCase();
    newJson[lowerCaseKey] = value;
  });
    return Barber(
      id: newJson['id'],
      email: newJson['email'],
      name: newJson['name'],
      lastName: newJson['lastname'],
      phoneNumber: newJson['phonenumber'] ?? '',
      earnings: newJson['earnings'].toDouble(),
      rating: newJson['rating'].toDouble(),
      image: newJson['imageurl'] ?? 'huy',
      reviews: (newJson['reviews'] as List? ?? [])
        .map((review) => Review.fromJson(review))
        .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': name,
      'lastName': lastName,
    };
  }
}
