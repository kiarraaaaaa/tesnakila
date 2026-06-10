class CampusModel {
  final String id;
  final String name;
  final String image;
  final String location;
  final String country;

  final double rating;
  final bool verified;

  final String description;
  final String history;

  final String foundedYear;
  final String worldRanking;

  final List<String> achievements;
  final List<String> programs;

  final bool isFavorite;

  CampusModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.country,
    required this.rating,
    required this.verified,
    required this.description,
    required this.history,
    required this.foundedYear,
    required this.worldRanking,
    required this.achievements,
    required this.programs,
    this.isFavorite = false,
  });

  factory CampusModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return CampusModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      image: map["image"] ?? "",
      location: map["location"] ?? "",
      country: map["country"] ?? "",
      rating:
          (map["rating"] ?? 0).toDouble(),
      verified:
          map["verified"] ?? false,
      description:
          map["description"] ?? "",
      history:
          map["history"] ?? "",
      foundedYear:
          map["foundedYear"] ?? "",
      worldRanking:
          map["worldRanking"] ?? "",
      achievements:
          List<String>.from(
        map["achievements"] ?? [],
      ),
      programs:
          List<String>.from(
        map["programs"] ?? [],
      ),
      isFavorite:
          map["isFavorite"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "location": location,
      "country": country,
      "rating": rating,
      "verified": verified,
      "description": description,
      "history": history,
      "foundedYear": foundedYear,
      "worldRanking": worldRanking,
      "achievements": achievements,
      "programs": programs,
      "isFavorite": isFavorite,
    };
  }
}