class Review {
  int? userId;
  int? animeId;
  String? review;

  Review({this.userId, this.animeId, this.review});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'anime_id': animeId,
      'review': review,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'] as int?,
      animeId: json['anime_id'] as int?,
      review: json['review'] as String?,
    );
  }

  @override
  String toString() {
    return 'Review{userId: $userId, animeId: $animeId, review: $review';
  }
}
