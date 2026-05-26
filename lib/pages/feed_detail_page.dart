import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/constants/mock_data.dart';
import 'package:shandada/models/feed.dart';
import 'package:shandada/models/user_profile.dart';
import 'package:shandada/pages/other_user_profile_page.dart';
import 'package:shandada/pages/report_page.dart';
import 'package:shandada/providers/feed_provider.dart';
import 'package:shandada/providers/user_provider.dart';
import 'package:shandada/providers/blocked_users_provider.dart';

class FeedDetailPage extends StatefulWidget {
  final Feed feed;

  const FeedDetailPage({
    super.key,
    required this.feed,
  });

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> with TickerProviderStateMixin {
  bool isLiked = false;
  late bool isBookmarked;
  bool isFollowed = false;
  late TextEditingController commentController;
  late AnimationController _likeAnimationController;
  late AnimationController _bookmarkAnimationController;
  late AnimationController _followAnimationController;
  late List<Map<String, String>> comments;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.feed.isBookmarked;
    comments = List.from(widget.feed.commentList);
    commentController = TextEditingController();
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _bookmarkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _followAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    _likeAnimationController.dispose();
    _bookmarkAnimationController.dispose();
    _followAnimationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    _likeAnimationController.forward(from: 0.0);
  }

  void _toggleBookmark() {
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    setState(() {
      isBookmarked = !isBookmarked;
    });
    
    feedProvider.toggleBookmark(widget.feed.id, userProvider.currentUser.name);
    _bookmarkAnimationController.forward(from: 0.0);
  }

  void _toggleFollow() {
    setState(() {
      isFollowed = !isFollowed;
    });
    _followAnimationController.forward(from: 0.0);
  }

  void _showMoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.slate300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _buildMoreMenuItem(
                icon: Icons.flag_outlined,
                label: '举报',
                onTap: () {
                  Navigator.pop(modalContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportPage(
                        contentType: 'feed',
                        contentId: widget.feed.id,
                        userName: widget.feed.userName,
                      ),
                    ),
                  );
                },
              ),
              _buildMoreMenuItem(
                icon: Icons.block_outlined,
                label: '拉黑',
                onTap: () {
                  Navigator.pop(modalContext);
                  // 拉黑用户
                  final blockedUsersProvider = Provider.of<BlockedUsersProvider>(context, listen: false);
                  blockedUsersProvider.blockUser(widget.feed.userName);
                  
                  // 显示反馈
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('已拉黑 ${widget.feed.userName}'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  
                  // 延迟后返回上一页
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
              _buildMoreMenuItem(
                icon: Icons.visibility_off_outlined,
                label: '屏蔽用户',
                onTap: () {
                  Navigator.pop(modalContext);
                  // 屏蔽用户
                  final blockedUsersProvider = Provider.of<BlockedUsersProvider>(context, listen: false);
                  blockedUsersProvider.muteUser(widget.feed.userName);
                  
                  // 显示反馈
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('已屏蔽 ${widget.feed.userName}'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                  
                  // 延迟后返回上一页
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                height: 1,
                color: AppColors.slate100,
              ),
              _buildMoreMenuItem(
                icon: Icons.close_outlined,
                label: '取消',
                isCancel: true,
                onTap: () {
                  Navigator.pop(modalContext);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoreMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isCancel = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isCancel ? AppColors.slate600 : AppColors.slate900,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isCancel ? AppColors.slate600 : AppColors.slate900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.slate600,
              size: 20,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _showMoreMenu(context);
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.more_vert,
                color: AppColors.slate600,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // 用户卡片
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.08),
                  AppColors.primary.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _navigateToUserProfile();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(widget.feed.userAvatar),
                            onBackgroundImageError: (exception, stackTrace) {},
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            _navigateToUserProfile();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.feed.userName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate900,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '5小时前·上海',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.slate500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _toggleFollow,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.1).animate(
                      CurvedAnimation(parent: _followAnimationController, curve: Curves.elasticOut),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isFollowed
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.white,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        isFollowed ? '已关注' : '关注',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 分类标签
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFF3E8FF).withValues(alpha: 0.8),
                  const Color(0xFFE9D5FF).withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.feed.categoryEmoji,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 6),
                Text(
                  widget.feed.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // 标题
          Text(
            widget.feed.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.slate900,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 12),

          // 内容图片
          if (widget.feed.images.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.feed.images[0],
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      color: AppColors.slate100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 16),

          // 内容描述
          Text(
            widget.feed.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.slate600,
              height: 1.7,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 20),

          // 互动按钮
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: AppColors.slate100,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.15).animate(
                    CurvedAnimation(parent: _likeAnimationController, curve: Curves.elasticOut),
                  ),
                  child: _buildInteractionButton(
                    icon: isLiked ? Icons.favorite : Icons.favorite_outline,
                    label: '${widget.feed.likes}',
                    isActive: isLiked,
                    onTap: _toggleLike,
                  ),
                ),
                _buildInteractionButton(
                  icon: Icons.chat_bubble_outline,
                  label: '${widget.feed.comments}',
                  isActive: false,
                  onTap: () {},
                ),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.15).animate(
                    CurvedAnimation(parent: _bookmarkAnimationController, curve: Curves.elasticOut),
                  ),
                  child: _buildInteractionButton(
                    icon: isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    label: '收藏',
                    isActive: isBookmarked,
                    onTap: _toggleBookmark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 评论区
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: AppColors.slate100,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '评论 (${comments.length})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate900,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      '全部',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 评论列表
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to comment user profile
                              if (comment['userName'] != '我') {
                                _navigateToCommentUserProfile(comment['userName']!, comment['userAvatar']!);
                              }
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(comment['userAvatar']!),
                              onBackgroundImageError: (exception, stackTrace) {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      comment['userName']!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.slate900,
                                      ),
                                    ),
                                    Text(
                                      comment['time']!,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.slate400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment['content']!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.slate600,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 评论输入框
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: AppColors.slate100,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: '写下你的评论...',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.slate400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.slate200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (commentController.text.isNotEmpty) {
                      setState(() {
                        comments.add({
                          'userName': '我',
                          'userAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&q=80',
                          'content': commentController.text,
                          'time': '刚刚',
                        });
                      });
                      commentController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('评论已发布'),
                          duration: Duration(milliseconds: 800),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.send,
                      size: 18,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? AppColors.primary : AppColors.slate600,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? AppColors.primary : AppColors.slate600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToUserProfile() {
    final userActivities = MockData.getActivitiesByUserName(widget.feed.userName);
    final profileData = MockData.getUserProfileData(widget.feed.userName);
    
    final userProfile = UserProfile(
      id: widget.feed.id,
      name: widget.feed.userName,
      avatar: widget.feed.userAvatar,
      signature: '这是用户签名',
      rating: profileData['rating'],
      followers: profileData['followers'],
      following: profileData['following'],
      isFollowed: false,
      activitiesInitiated: [],
      activitiesHistory: [],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
          userProfile: userProfile,
          activities: userActivities,
        ),
      ),
    );
  }

  void _navigateToCommentUserProfile(String userName, String userAvatar) {
    final userActivities = MockData.getActivitiesByUserName(userName);
    final profileData = MockData.getUserProfileData(userName);
    
    final userProfile = UserProfile(
      id: userName,
      name: userName,
      avatar: userAvatar,
      signature: '这是用户签名',
      rating: profileData['rating'],
      followers: profileData['followers'],
      following: profileData['following'],
      isFollowed: false,
      activitiesInitiated: [],
      activitiesHistory: [],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
          userProfile: userProfile,
          activities: userActivities,
        ),
      ),
    );
  }
}
