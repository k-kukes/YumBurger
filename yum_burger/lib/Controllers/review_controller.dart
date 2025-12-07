import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/review_model.dart';

class ReviewController {
  final String _apiUrl = "https://jsonplaceholder.typicode.com/comments";

  Future<List<Review>> fetchReviews() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return data.take(20).map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load reviews");
      }
    } catch (e) {
      print("Error fetching reviews: $e");
      return [];
    }
  }
}