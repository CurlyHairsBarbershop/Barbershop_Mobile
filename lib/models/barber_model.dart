import 'package:curly_hairs/models/user_model.dart';
import 'package:curly_hairs/models/review_model.dart';

class Barber extends UserData {
  //final int id;
  final double earnings;
  final double rating;
  final String image;
  final List<Review> reviews;

  Barber({
    //required this.id,
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
    return Barber(
      //id: json['id'],
      email: json['email'],
      name: json['name'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'] ?? '',
      earnings: json['earnings'].toDouble(),
      rating: json['rating'].toDouble(),
      image: json['image'] ?? '',
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': name,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'earnings': earnings,
      'rating': rating,
      'image': image,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
