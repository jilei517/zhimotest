class User {
  final String id;
  final String name;
  final String bio;
  final String avatar;
  final int followers;
  final int likes;
  final int collections;
  final int following;
  final double rating;
  final int publishedActivities;
  final int participatedActivities;
  final String gender; // 性别: 男/女/其他
  final int age; // 年龄
  final List<String> interests; // 兴趣爱好
  final String mbti; // MBTI类型
  final String signature; // 个性签名

  User({
    required this.id,
    required this.name,
    required this.bio,
    required this.avatar,
    required this.followers,
    required this.likes,
    required this.collections,
    required this.following,
    required this.rating,
    required this.publishedActivities,
    required this.participatedActivities,
    this.gender = '男',
    this.age = 18,
    this.interests = const [],
    this.mbti = 'ENFP',
    this.signature = '',
  });

  User copyWith({
    String? id,
    String? name,
    String? bio,
    String? avatar,
    int? followers,
    int? likes,
    int? collections,
    int? following,
    double? rating,
    int? publishedActivities,
    int? participatedActivities,
    String? gender,
    int? age,
    List<String>? interests,
    String? mbti,
    String? signature,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      followers: followers ?? this.followers,
      likes: likes ?? this.likes,
      collections: collections ?? this.collections,
      following: following ?? this.following,
      rating: rating ?? this.rating,
      publishedActivities: publishedActivities ?? this.publishedActivities,
      participatedActivities: participatedActivities ?? this.participatedActivities,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      interests: interests ?? this.interests,
      mbti: mbti ?? this.mbti,
      signature: signature ?? this.signature,
    );
  }
}
