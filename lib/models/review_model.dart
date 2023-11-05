import 'package:curly_hairs/models/user_model.dart';

class Review {
  final String content;
  final double rating;
  final UserData publisher;

  Review({
    required this.content,
    required this.rating,
    required this.publisher,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    print(json);
    return Review(
      content: json['content'],
      rating: json['rating'].toDouble(),
      publisher: UserData.fromJson(json['publisher']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'rating': rating,
      //'publisher': publisher.toJson(),
    };
  }
}