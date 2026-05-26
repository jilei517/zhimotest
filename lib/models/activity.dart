class Activity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String categoryEmoji;
  final String imageUrl;
  final String userName;
  final String userAvatar;
  final int likes;
  final int participants;
  final double distance;
  final String location;
  final DateTime createdAt;
  final bool isFull;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.categoryEmoji,
    required this.imageUrl,
    required this.userName,
    required this.userAvatar,
    required this.likes,
    required this.participants,
    required this.distance,
    required this.location,
    required this.createdAt,
    this.isFull = false,
  });

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? categoryEmoji,
    String? imageUrl,
    String? userName,
    String? userAvatar,
    int? likes,
    int? participants,
    double? distance,
    String? location,
    DateTime? createdAt,
    bool? isFull,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryEmoji: categoryEmoji ?? this.categoryEmoji,
      imageUrl: imageUrl ?? this.imageUrl,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      likes: likes ?? this.likes,
      participants: participants ?? this.participants,
      distance: distance ?? this.distance,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      isFull: isFull ?? this.isFull,
    );
  }
}
