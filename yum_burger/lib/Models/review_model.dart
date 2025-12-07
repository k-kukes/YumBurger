import 'dart:math';

class Review {
  final int id;
  final String authorName;
  final String content;
  final int rating;

  Review({
    required this.id,
    required this.authorName,
    required this.content,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    int randomRating = 3 + Random().nextInt(3);

    return Review(
      id: json['id'],
      authorName: json['email'].toString().split('@')[0],
      content: json['body'].toString().replaceAll('\n', ' '),
      rating: randomRating,
    );
  }
}