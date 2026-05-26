import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/constants/mock_data.dart';
import 'package:shandada/models/activity.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shandada/pages/activity_detail_page.dart';
import 'package:shandada/providers/blocked_users_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> categories;
  late int selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    categories = MockData.categories;
    selectedCategoryIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Activity> _getFilteredActivities(BlockedUsersProvider blockedUsersProvider) {
    List<Activity> activities;
    if (selectedCategoryIndex == 0) {
      activities = MockData.homeActivities;
    } else {
      final selectedCategory = categories[selectedCategoryIndex];
      activities = MockData.homeActivities
          .where((activity) => activity.category == selectedCategory)
          .toList();
    }
    
    // Filter out blocked/muted users
    return activities
        .where((activity) => !blockedUsersProvider.shouldFilterUser(activity.userName))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockedUsersProvider>(
      builder: (context, blockedUsersProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.slate50,
          body: CustomScrollView(
            slivers: [
              // 顶部安全区域
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
              ),

              // 分类标签 - 优雅的水平滚动
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: List.generate(
                      categories.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: selectedCategoryIndex == index
                                  ? AppColors.primaryGradient
                                  : null,
                              color: selectedCategoryIndex == index
                                  ? null
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: selectedCategoryIndex == index
                                  ? Border.all(
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                      width: 0,
                                    )
                                  : Border.all(
                                      color: AppColors.slate200,
                                      width: 1.2,
                                    ),
                              boxShadow: [
                                if (selectedCategoryIndex == index)
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: selectedCategoryIndex == index ? 0.08 : 0.04,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: selectedCategoryIndex == index
                                    ? AppColors.white
                                    : AppColors.slate600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 卡片列表 - 瀑布流布局
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childCount: _getFilteredActivities(blockedUsersProvider).length,
                  itemBuilder: (context, index) {
                    final activity = _getFilteredActivities(blockedUsersProvider)[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityDetailPage(activity: activity),
                          ),
                        );
                      },
                      child: _buildActivityCard(activity),
                    );
                  },
                ),
              ),

              // 底部留白
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivityCard(Activity activity) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // 微妙的主阴影
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          // 细腻的边缘阴影
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 图片区域 - 沉浸式体验 (高度: 160)
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.slate200.withValues(alpha: 0.5),
                        AppColors.slate100.withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Image.network(
                    activity.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.slate300,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 距离标签 - 优雅的玻璃态设计
              Positioned(
                bottom: 12,
                left: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 11,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${activity.distance}km',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 内容区域 - 清晰的信息层级 (动态高度)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 用户信息和互动 (高度: 36)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundImage:
                                  NetworkImage(activity.userAvatar),
                              onBackgroundImageError:
                                  (exception, stackTrace) {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  activity.userName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.slate800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '2小时前',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: AppColors.slate400,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 点赞按钮 - 微交互
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            size: 11,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${activity.likes}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // 留白
                const SizedBox(height: 6),

                // 活动标题 - 视线聚焦 (动态高度，最多2行)
                Text(
                  activity.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate900,
                    height: 1.4,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
