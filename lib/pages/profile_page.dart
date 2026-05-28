import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/models/feed.dart';
import 'package:shandada/pages/edit_profile_page.dart';
import 'package:shandada/pages/feed_detail_page.dart';
import 'package:shandada/pages/settings_page.dart';
import 'package:shandada/providers/user_provider.dart';
import 'package:shandada/providers/feed_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int selectedTabIndex;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedTabIndex = 0;
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.currentUser;
          
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 渐变头部 - 扩展背景
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.8),
                        AppColors.primary.withValues(alpha: 0.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      // 顶部空间和设置按钮
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 52, 16, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 40),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingsPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.settings_outlined,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 用户头像 - 居中
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 4,
                            ),
                            image: DecorationImage(
                              image: user.avatar.startsWith('http')
                                  ? NetworkImage(user.avatar)
                                  : FileImage(File(user.avatar)) as ImageProvider,
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {},
                            ),
                          ),
                        ),
                      ),
                      // 昵称和签名 - 在头像下方
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              user.signature.isNotEmpty ? user.signature : user.bio,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 编辑资料按钮
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  user: user,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '编辑资料',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.slate600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 用户标签和简介
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 用户简介
                      Text(
                        user.bio,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.slate600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 用户标签（MBTI、兴趣爱好等）
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (user.mbti.isNotEmpty)
                        _buildTagChip(user.mbti),
                      ...user.interests.take(2).map((interest) => _buildTagChip(interest)),
                    ],
                  ),
                ),
              ),

              // 统计数据
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('128', '获赞与收藏'),
                      _buildStatColumn('45', '关注'),
                      _buildStatColumn('${user.followers}', '粉丝'),
                    ],
                  ),
                ),
              ),

              // 标签页
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTabIndex = 0;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    border: selectedTabIndex == 0
                                        ? Border(
                                            bottom: BorderSide(
                                              color: AppColors.primary,
                                              width: 3,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '我的发现',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: selectedTabIndex == 0
                                            ? AppColors.primary
                                            : AppColors.slate400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTabIndex = 1;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    border: selectedTabIndex == 1
                                        ? Border(
                                            bottom: BorderSide(
                                              color: AppColors.primary,
                                              width: 3,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '收藏夹',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: selectedTabIndex == 1
                                            ? AppColors.primary
                                            : AppColors.slate400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: AppColors.slate200,
                      ),
                    ],
                  ),
                ),
              ),

              // 标签页内容 - 我的发现（用户发布的动态）或收藏夹（收藏的动态）
              if (selectedTabIndex == 0)
                Consumer<FeedProvider>(
                  builder: (context, feedProvider, child) {
                    final currentUser = userProvider.currentUser;
                    
                    // 过滤出当前用户发布的动态
                    final userFeeds = feedProvider.feeds
                        .where((feed) => feed.userName == currentUser.name)
                        .toList();

                    if (userFeeds.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Container(
                          color: AppColors.slate50,
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                  color: AppColors.slate300,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '还没有发布过动态',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.slate400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final feed = userFeeds[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FeedDetailPage(feed: feed),
                                        ),
                                      );
                                    },
                                    child: _buildFeedCard(feed),
                                  ),
                                  // 删除按钮（右上角）
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        _showDeleteFeedDialog(context, feed, feedProvider);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(alpha: 0.9),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.15),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: userFeeds.length,
                        ),
                      ),
                    );
                  },
                )
              else
                Consumer<FeedProvider>(
                  builder: (context, feedProvider, child) {
                    final currentUser = userProvider.currentUser;
                    
                    // 获取当前用户收藏的动态
                    final bookmarkedFeeds = feedProvider.getBookmarkedFeeds(currentUser.name);

                    if (bookmarkedFeeds.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Container(
                          color: AppColors.slate50,
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.bookmark_outline,
                                  size: 48,
                                  color: AppColors.slate300,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '还没有收藏过动态',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.slate400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final feed = bookmarkedFeeds[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeedDetailPage(feed: feed),
                                    ),
                                  );
                                },
                                child: _buildFeedCard(feed),
                              ),
                            );
                          },
                          childCount: bookmarkedFeeds.length,
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.slate100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.slate600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 删除自己帖子的确认弹窗
  void _showDeleteFeedDialog(
      BuildContext context, Feed feed, FeedProvider feedProvider) {
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
                  '删除动态',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '确定要删除这条动态吗？删除后无法恢复。',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.slate600,
                    height: 1.5,
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
                          feedProvider.removeFeed(feed.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('动态已删除'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '删除',
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

  /// 根据路径自动判断使用本地文件还是网络图片
  Widget _buildImage(String imagePath, double height) {    final isLocal = !imagePath.startsWith('http');
    return isLocal
        ? Image.file(
            File(imagePath),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _imagePlaceholder(height),
          )
        : Image.network(
            imagePath,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _imagePlaceholder(height),
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

  Widget _buildStatColumn(String value, String label) {    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.slate600,
          ),
        ),
      ],
    );
  }

  Widget _buildFeedCard(Feed feed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
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

          // 标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              feed.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.slate900,
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
                child: _buildImage(feed.images[0], 200),
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
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.favorite_outline,
                            size: 18,
                            color: AppColors.slate600,
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
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
                      onTap: () {},
                      child: const Icon(
                        Icons.bookmark_outline,
                        size: 18,
                        color: AppColors.slate600,
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
