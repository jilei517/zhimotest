import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/models/feed.dart';
import 'package:shandada/pages/feed_detail_page.dart';
import 'package:shandada/pages/discover_publish_modal.dart';
import 'package:shandada/providers/feed_provider.dart';
import 'package:shandada/providers/user_provider.dart';
import 'package:shandada/providers/blocked_users_provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // 存储每个动态的交互状态
  final Map<String, bool> _followedFeeds = {};
  final Map<String, bool> _likedFeeds = {};
  final Map<String, bool> _bookmarkedFeeds = {};

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
                  Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 18,
                  ),
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
          // 过滤掉当前用户的动态，只显示其他用户的动态
          // 同时过滤掉被拉黑和屏蔽的用户的动态
          final otherUserFeeds = feedProvider.feeds
              .where((feed) => 
                  feed.userName != userProvider.currentUser.name &&
                  !blockedUsersProvider.shouldFilterUser(feed.userName))
              .toList();

          if (otherUserFeeds.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.feed_outlined,
                    size: 64,
                    color: AppColors.slate300,
                  ),
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
            itemCount: otherUserFeeds.length,
            itemBuilder: (context, index) {
              final feed = otherUserFeeds[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedDetailPage(feed: feed),
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
                            Text(
                              '5小时前·上海',
                              style: const TextStyle(
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

          // 内容图片
          if (feed.images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  feed.images[0],
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 280,
                      color: AppColors.slate100,
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                ),
              ),
            ),

          const SizedBox(height: 12),

          // 互动按钮和点赞数
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 互动按钮
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
                            builder: (context) => FeedDetailPage(feed: feed),
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

                // 点赞数
                Text(
                  '${feed.likes}次点赞',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate600,
                  ),
                ),

                const SizedBox(height: 8),

                // 内容文本
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

                // 评论数
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
}
