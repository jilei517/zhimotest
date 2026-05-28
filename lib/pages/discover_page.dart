import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/models/feed.dart';
import 'package:shandada/pages/feed_detail_page.dart';
import 'package:shandada/pages/discover_publish_modal.dart';
import 'package:shandada/pages/report_page.dart';
import 'package:shandada/providers/feed_provider.dart';
import 'package:shandada/providers/user_provider.dart';
import 'package:shandada/providers/blocked_users_provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final Map<String, bool> _followedFeeds = {};
  final Map<String, bool> _likedFeeds = {};
  final Map<String, bool> _bookmarkedFeeds = {};
  // 用户手动从列表移除的帖子 id
  final Set<String> _hiddenFeedIds = {};

  /// 显示举报/屏蔽/删除菜单
  void _showFeedMenu(BuildContext context, Feed feed) {
    final blockedUsersProvider =
        Provider.of<BlockedUsersProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
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
              const SizedBox(height: 8),

              // 举报
              _buildMenuItem(
                icon: Icons.flag_outlined,
                label: '举报不良内容',
                onTap: () {
                  Navigator.pop(modalContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportPage(
                        contentType: 'feed',
                        contentId: feed.id,
                        userName: feed.userName,
                      ),
                    ),
                  );
                },
              ),

              // 屏蔽用户
              _buildMenuItem(
                icon: Icons.visibility_off_outlined,
                label: '屏蔽该用户',
                onTap: () {
                  Navigator.pop(modalContext);
                  blockedUsersProvider.muteUser(feed.userName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('已屏蔽 ${feed.userName}，其内容将不再显示'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
              ),

              // 拉黑用户
              _buildMenuItem(
                icon: Icons.block_outlined,
                label: '拉黑该用户',
                onTap: () {
                  Navigator.pop(modalContext);
                  blockedUsersProvider.blockUser(feed.userName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('已拉黑 ${feed.userName}'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),

              // 从动态流移除（立即隐藏）
              _buildMenuItem(
                icon: Icons.remove_circle_outline,
                label: '不感兴趣，移除此条',
                onTap: () {
                  Navigator.pop(modalContext);
                  setState(() {
                    _hiddenFeedIds.add(feed.id);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('已从动态流中移除'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),

              const Divider(height: 1, color: AppColors.slate100),

              // 取消
              _buildMenuItem(
                icon: Icons.close,
                label: '取消',
                isCancel: true,
                onTap: () => Navigator.pop(modalContext),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isCancel = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isCancel ? AppColors.slate500 : AppColors.slate900,
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isCancel ? AppColors.slate500 : AppColors.slate900,
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
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          '发现',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const DiscoverPublishModal(),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.white, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '发布',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Consumer3<FeedProvider, UserProvider, BlockedUsersProvider>(
        builder: (context, feedProvider, userProvider, blockedUsersProvider, child) {
          final visibleFeeds = feedProvider.feeds
              .where((feed) =>
                  feed.userName != userProvider.currentUser.name &&
                  !blockedUsersProvider.shouldFilterUser(feed.userName) &&
                  !_hiddenFeedIds.contains(feed.id))
              .toList();

          if (visibleFeeds.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feed_outlined, size: 64, color: AppColors.slate300),
                  const SizedBox(height: 16),
                  Text(
                    '暂无动态',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.slate400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: visibleFeeds.length,
            itemBuilder: (context, index) {
              final feed = visibleFeeds[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedDetailPage(feed: feed),
                    ),
                  );
                },
                child: _buildFeedCard(feed),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFeedCard(Feed feed) {
    final isFollowed = _followedFeeds[feed.id] ?? false;
    final isLiked = _likedFeeds[feed.id] ?? false;
    final isBookmarked = _bookmarkedFeeds[feed.id] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息头部
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(feed.userAvatar),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feed.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.slate900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              '5小时前·上海',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.slate400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // 关注按钮
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _followedFeeds[feed.id] = !isFollowed;
                        });
                      },
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
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(16),
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
                    const SizedBox(width: 8),
                    // 更多操作按钮（举报/屏蔽/移除）
                    GestureDetector(
                      onTap: () => _showFeedMenu(context, feed),
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: AppColors.slate400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 分类标签
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                feed.category,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 内容图片（支持本地路径和网络 URL）
          if (feed.images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildFeedImage(feed.images[0], 280),
              ),
            ),

          const SizedBox(height: 12),

          // 互动按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _likedFeeds[feed.id] = !isLiked;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_outline,
                            size: 18,
                            color: isLiked ? Colors.red : AppColors.slate600,
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeedDetailPage(feed: feed),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 18,
                            color: AppColors.slate600,
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _bookmarkedFeeds[feed.id] = !isBookmarked;
                        });
                      },
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                        size: 18,
                        color: isBookmarked ? AppColors.primary : AppColors.slate600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  '${feed.likes}次点赞',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  feed.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate900,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  feed.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.slate600,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '${feed.comments}条评论',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.slate400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  /// 根据路径自动判断本地文件还是网络图片
  Widget _buildFeedImage(String imagePath, double height) {
    final isLocal = !imagePath.startsWith('http');
    if (isLocal) {
      return Image.file(
        File(imagePath),
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imagePlaceholder(height),
      );
    }
    return Image.network(
      imagePath,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imagePlaceholder(height),
    );
  }

  Widget _imagePlaceholder(double height) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.slate100,
      child: const Center(
        child: Icon(Icons.image_not_supported, color: AppColors.slate400),
      ),
    );
  }
}
