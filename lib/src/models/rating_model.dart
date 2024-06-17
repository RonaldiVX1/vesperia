import 'package:entrance_test/src/models/user_model.dart';

class RatingModel {
  final String review;
  final int rating;
  final bool isAnonymous;
  final UserModel user;

  RatingModel({required this.review, required this.rating, required this.isAnonymous, required this.user});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        review: json['review'],
        rating: json['rating'],
        isAnonymous: json['is_anonymous'],
        user: UserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'review': review,
        'rating': rating,
        'is_anonymous': isAnonymous,
        'user': user,
      };
}
