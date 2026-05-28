import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/constants/mock_data.dart';
import 'package:shandada/models/activity.dart';
import 'package:shandada/models/user_profile.dart';
import 'package:shandada/pages/other_user_profile_page.dart';
import 'package:shandada/pages/report_page.dart';
import 'package:shandada/providers/blocked_users_provider.dart';

class ActivityDetailPage extends StatefulWidget {
  final Activity activity;

  const ActivityDetailPage({
    super.key,
    required this.activity,
  });

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  bool isLiked = false;
  bool isBookmarked = false;
  bool isJoined = false;
  late int likeCount;
  late TextEditingController _commentController;
  late ScrollController _scrollController;
  
  List<Map<String, String>> comments = [
    {
      'userName': '张三',
      'userAvatar': 'https://picsum.photos/100/100?random=27',
      'content': '这个活动看起来很不错，我也想参加！',
      'time': '2小时前',
    },
    {
      'userName': '李四',
      'userAvatar': 'https://picsum.photos/100/100?random=28',
      'content': '请问具体时间是什么时候呢？',
      'time': '1小时前',
    },
    {
      'userName': '王五',
      'userAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&q=80',
      'content': '我上次参加过类似的活动，非常有趣！',
      'time': '30分钟前',
    },
  ];

  @override
  void initState() {
    super.initState();
    likeCount = widget.activity.likes;
    _commentController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
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
        controller: _scrollController,
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
                            backgroundImage: NetworkImage(widget.activity.userAvatar),
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
                                widget.activity.userName,
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
                                '${widget.activity.distance}km · ${widget.activity.location}',
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
                  onTap: () {
                    setState(() {
                      isJoined = !isJoined;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isJoined
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
                      isJoined ? '已参加' : '参加',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
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
                  widget.activity.categoryEmoji,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 6),
                Text(
                  widget.activity.category,
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
            widget.activity.title,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.activity.imageUrl,
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
            widget.activity.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.slate600,
              height: 1.7,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 20),

          // 活动信息卡片
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
                const Text(
                  '活动信息',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: '活动时间',
                  value: _formatDateTime(widget.activity.createdAt),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.location_on,
                  label: '活动地点',
                  value: widget.activity.location,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.people,
                  label: '参加人数',
                  value: '${widget.activity.participants}人${widget.activity.isFull ? '（已满）' : ''}',
                ),
              ],
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
                _buildInteractionButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_outline,
                  label: '$likeCount',
                  isActive: isLiked,
                  onTap: () {
                    setState(() {
                      if (isLiked) {
                        likeCount--;
                      } else {
                        likeCount++;
                      }
                      isLiked = !isLiked;
                    });
                  },
                ),
                _buildInteractionButton(
                  icon: Icons.chat_bubble_outline,
                  label: '评论',
                  isActive: false,
                  onTap: () {},
                ),
                _buildInteractionButton(
                  icon: isBookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                  label: '收藏',
                  isActive: isBookmarked,
                  onTap: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 评论区标题
          const Text(
            '评论',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 12),

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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: const NetworkImage(
                      'https://picsum.photos/100/100?random=29',
                    ),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: '说说你的想法...',
                      hintStyle: const TextStyle(
                        color: AppColors.slate400,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.slate900,
                    ),
                    maxLines: 1,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        comments.insert(0, {
                          'userName': '我',
                          'userAvatar': 'https://picsum.photos/100/100?random=29',
                          'content': _commentController.text,
                          'time': '刚刚',
                        });
                        _commentController.clear();
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '发送',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 评论列表
          if (comments.isNotEmpty)
            Column(
              children: List.generate(
                comments.length,
                (index) {
                  final comment = comments[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.slate100,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigate to comment user profile
                                  if (comment['userName'] != '我') {
                                    _navigateToCommentUserProfile(comment['userName']!, comment['userAvatar']!);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage(comment['userAvatar']!),
                                    onBackgroundImageError: (exception, stackTrace) {},
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment['userName']!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.slate900,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      comment['time']!,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.slate500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            comment['content']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.slate700,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.slate600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.slate900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  void _navigateToUserProfile() {
    final userActivities = MockData.getActivitiesByUserName(widget.activity.userName);
    final profileData = MockData.getUserProfileData(widget.activity.userName);
    
    final userProfile = UserProfile(
      id: widget.activity.id,
      name: widget.activity.userName,
      avatar: widget.activity.userAvatar,
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
                        contentType: 'activity',
                        contentId: widget.activity.id,
                        userName: widget.activity.userName,
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
                  _showBlockConfirmDialog(context);
                },
              ),
              _buildMoreMenuItem(
                icon: Icons.visibility_off_outlined,
                label: '屏蔽用户',
                onTap: () {
                  Navigator.pop(modalContext);
                  _showMuteConfirmDialog(context);
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

  /// 拉黑确认弹窗
  void _showBlockConfirmDialog(BuildContext context) {
    final navigator = Navigator.of(context);
    final blockedUsersProvider =
        Provider.of<BlockedUsersProvider>(context, listen: false);
    final messenger = ScaffoldMessenger.of(context);
    final userName = widget.activity.userName;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '拉黑用户',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '确定要拉黑「$userName」吗？\n拉黑后该用户的所有活动和动态将从列表中移除。',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.slate600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(dialogContext),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.slate100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '取消',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.slate600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(dialogContext);
                          // 执行拉黑，BlockedUsersProvider 通知监听者
                          // activity_calendar_page 的 Consumer 会自动重建过滤列表
                          blockedUsersProvider.blockUser(userName);
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('已拉黑 $userName，其活动已从列表移除'),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                          // 返回上一页（日历页 Consumer 会自动刷新）
                          navigator.pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '确认拉黑',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 屏蔽确认弹窗
  void _showMuteConfirmDialog(BuildContext context) {
    final navigator = Navigator.of(context);
    final blockedUsersProvider =
        Provider.of<BlockedUsersProvider>(context, listen: false);
    final messenger = ScaffoldMessenger.of(context);
    final userName = widget.activity.userName;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '屏蔽用户',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '确定要屏蔽「$userName」吗？\n屏蔽后该用户的活动将不再显示在列表中。',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.slate600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(dialogContext),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.slate100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '取消',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.slate600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(dialogContext);
                          blockedUsersProvider.muteUser(userName);
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('已屏蔽 $userName，其活动已从列表移除'),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          navigator.pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '确认屏蔽',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
}
