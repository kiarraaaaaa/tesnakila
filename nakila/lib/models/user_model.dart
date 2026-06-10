class UserModel {
  final String uid;

  final String name;
  final String email;

  final String role;

  final String profileImage;

  final bool verified;

  final List<String> favorites;

  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.verified,
    required this.favorites,
    required this.createdAt,
  });

  factory UserModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserModel(
      uid: map["uid"] ?? "",

      name: map["name"] ?? "",

      email: map["email"] ?? "",

      role: map["role"] ?? "user",

      profileImage:
          map["profileImage"] ?? "",

      verified:
          map["verified"] ?? false,

      favorites:
          List<String>.from(
        map["favorites"] ?? [],
      ),

      createdAt:
          DateTime.tryParse(
                map["createdAt"] ?? "",
              ) ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "role": role,
      "profileImage": profileImage,
      "verified": verified,
      "favorites": favorites,
      "createdAt":
          createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    String? profileImage,
    bool? verified,
    List<String>? favorites,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profileImage:
          profileImage ??
              this.profileImage,
      verified:
          verified ?? this.verified,
      favorites:
          favorites ?? this.favorites,
      createdAt:
          createdAt ?? this.createdAt,
    );
  }
}