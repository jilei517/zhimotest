class UserProfile {
  final String id;
  final String name;
  final String avatar;
  final String signature;
  final double rating;
  final int followers;
  final int following;
  final bool isFollowed;
  final List<String> activitiesInitiated; // 正在发起的活动 ID
  final List<String> activitiesHistory; // 历史发起的活动 ID

  UserProfile({
    required this.id,
    required this.name,
    required this.avatar,
    required this.signature,
    required this.rating,
    required this.followers,
    required this.following,
    this.isFollowed = false,
    required this.activitiesInitiated,
    required this.activitiesHistory,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? avatar,
    String? signature,
    double? rating,
    int? followers,
    int? following,
    bool? isFollowed,
    List<String>? activitiesInitiated,
    List<String>? activitiesHistory,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      signature: signature ?? this.signature,
      rating: rating ?? this.rating,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowed: isFollowed ?? this.isFollowed,
      activitiesInitiated: activitiesInitiated ?? this.activitiesInitiated,
      activitiesHistory: activitiesHistory ?? this.activitiesHistory,
    );
  }
}
