import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/constants/mock_data.dart';
import 'package:shandada/models/activity.dart';
import 'package:shandada/pages/activity_detail_page.dart';
import 'package:shandada/providers/blocked_users_provider.dart';

class ActivityCalendarPage extends StatefulWidget {
  const ActivityCalendarPage({super.key});

  @override
  State<ActivityCalendarPage> createState() => _ActivityCalendarPageState();
}

class _ActivityCalendarPageState extends State<ActivityCalendarPage> {
  late int selectedTabIndex;
  late Set<String> deletedActivityIds; // 跟踪已删除的活动

  @override
  void initState() {
    super.initState();
    selectedTabIndex = 0;
    deletedActivityIds = {};
  }

  List<Activity> _getHistoryActivities(Set<String> blockedUsers) {
    // 返回历史参与的活动（已完成），排除已删除的和被拉黑/屏蔽用户的活动
    return MockData.homeActivities
        .take(5)
        .where((activity) =>
            !deletedActivityIds.contains(activity.id) &&
            !blockedUsers.contains(activity.userName))
        .toList();
  }

  List<Activity> _getOngoingActivities(Set<String> blockedUsers) {
    // 返回进行中的活动，排除已删除的和被拉黑/屏蔽用户的活动
    return MockData.homeActivities
        .skip(5)
        .take(5)
        .where((activity) =>
            !deletedActivityIds.contains(activity.id) &&
            !blockedUsers.contains(activity.userName))
        .toList();
  }

  void _deleteActivity(String activityId) {
    setState(() {
      deletedActivityIds.add(activityId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('活动已删除'),
        duration: Duration(seconds: 2),
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
          '活动日历',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
      ),
      body: Column(
        children: [
          // 标签页
          Container(
            color: AppColors.white,
            child: Padding(
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
                            '历史参与',
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
                            '进行中',
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
          ),
          Container(
            height: 1,
            color: AppColors.slate200,
          ),
          // 内容区域
          Expanded(
            child: Consumer<BlockedUsersProvider>(
              builder: (context, blockedUsersProvider, child) {
                // 合并拉黑和屏蔽的用户名集合
                final filteredUsers = {
                  ...blockedUsersProvider.blockedUsers,
                  ...blockedUsersProvider.mutedUsers,
                };
                final activities = selectedTabIndex == 0
                    ? _getHistoryActivities(filteredUsers)
                    : _getOngoingActivities(filteredUsers);

                if (activities.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy_outlined,
                          size: 56,
                          color: AppColors.slate300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '暂无活动',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.slate400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ActivityDetailPage(activity: activity),
                            ),
                          );
                        },
                        child: _buildActivityCard(activity, selectedTabIndex == 0),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Activity activity, bool isHistory) {
    return Container(
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图片区域
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                Image.network(
                  activity.imageUrl,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 160,
                      color: AppColors.slate100,
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                ),
                // 状态标签
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isHistory
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isHistory ? '已完成' : '进行中',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isHistory
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF2196F3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 内容区域
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 分类标签
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 12,
                        color: Color(0xFFFF9800),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        activity.category,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFFFF9800),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // 标题
                Text(
                  activity.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate900,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                // 活动信息
                Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: AppColors.slate400,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${activity.createdAt.month}月${activity.createdAt.day}日',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.slate500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 12,
                          color: AppColors.slate400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          activity.location,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.slate500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 参与人数和删除按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          size: 12,
                          color: AppColors.slate400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${activity.participants}人参加',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.slate500,
                          ),
                        ),
                      ],
                    ),
                    // 删除按钮
                    GestureDetector(
                      onTap: () {
                        _deleteActivity(activity.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 12,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '删除',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
