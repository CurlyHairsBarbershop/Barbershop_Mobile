import 'package:curly_hairs/models/reply_model.dart';
import 'package:curly_hairs/models/user_model.dart';

class Review {
  final int id;
  final String content;
  final double rating;
  final UserData publisher;
  final List<Reply> replies;

  Review({
    required this.id,
    required this.content,
    required this.rating,
    required this.publisher,
    required this.replies,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    print(json);
    return Review(
      id: json['id'],
      content: json['content'],
      rating: json['rating'].toDouble(),
      publisher: UserData.fromJson(json['publisher']),
      replies: (json['replies'] as List)
          .map((reply) => Reply.fromJson(reply))
          .toList(),
    );
  }

  // TO DO
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'rating': rating,
      //'publisher': publisher.toJson(),
    };
  }
}