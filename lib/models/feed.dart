class Feed {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String ratingLabel;
  final String title;
  final String description;
  final List<String> images;
  final String category;
  final String categoryEmoji;
  final int likes;
  final int comments;
  final DateTime createdAt;
  final bool isBookmarked;
  final String? bookmarkedBy; // Track which user bookmarked this feed
  final List<Map<String, String>> commentList; // 评论列表

  Feed({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.ratingLabel,
    required this.title,
    required this.description,
    required this.images,
    required this.category,
    required this.categoryEmoji,
    required this.likes,
    required this.comments,
    required this.createdAt,
    this.isBookmarked = false,
    this.bookmarkedBy,
    this.commentList = const [],
  });

  Feed copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    double? rating,
    String? ratingLabel,
    String? title,
    String? description,
    List<String>? images,
    String? category,
    String? categoryEmoji,
    int? likes,
    int? comments,
    DateTime? createdAt,
    bool? isBookmarked,
    String? bookmarkedBy,
    List<Map<String, String>>? commentList,
  }) {
    return Feed(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      rating: rating ?? this.rating,
      ratingLabel: ratingLabel ?? this.ratingLabel,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      category: category ?? this.category,
      categoryEmoji: categoryEmoji ?? this.categoryEmoji,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      bookmarkedBy: bookmarkedBy ?? this.bookmarkedBy,
      commentList: commentList ?? this.commentList,
    );
  }
}
