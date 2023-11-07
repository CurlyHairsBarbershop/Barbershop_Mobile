import 'package:curly_hairs/models/user_model.dart';

class Reply {
  final int id;
  final String content;
  final UserData publisher;
  final List<Reply> replies;

  Reply({
    required this.id,
    required this.content,
    required this.publisher,
    required this.replies,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    print(json);
    return Reply(
      id: json['id'],
      content: json['content'],
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
      //'publisher': publisher.toJson(),
    };
  }
}