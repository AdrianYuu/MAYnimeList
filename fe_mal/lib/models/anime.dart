class Anime {
  int? id;
  String? name;
  String? description;
  String? genre;
  double? rating;
  int? totalEpisode;
  String? imageUrl;

  Anime(
      {this.id,
      this.name,
      this.description,
      this.genre,
      this.rating,
      this.totalEpisode,
      this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "genre": genre,
      "rating": rating,
      "total_episode": totalEpisode,
      "image_url": imageUrl,
    };
  }

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json["id"] as int?,
      name: json["name"] as String?,
      description: json["description"] as String?,
      genre: json["genre"] as String?,
      rating: double.tryParse(json["rating"]),
      totalEpisode: json["total_episode"] as int?,
      imageUrl: json["image_url"] as String?,
    );
  }

  @override
  String toString() {
    return "Anime{id: $id, name: $name, description: $description, genre: $genre, rating: $rating, totalEpisode: $totalEpisode, imageUrl: $imageUrl}";
  }
}
