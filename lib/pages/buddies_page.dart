import 'package:flutter/material.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/constants/mock_data.dart';
import 'package:shandada/models/activity.dart';
import 'package:shandada/pages/buddy_detail_page.dart';

class BuddiesPage extends StatefulWidget {
  const BuddiesPage({super.key});

  @override
  State<BuddiesPage> createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  late int selectedFilterIndex;
  late List<String> filters;
  late String selectedCategory;
  late String selectedCity;
  late List<String> allCategories;
  late List<String> allCities;

  @override
  void initState() {
    super.initState();
    selectedFilterIndex = 0;
    filters = ['离我最近', '最新发布'];
    selectedCategory = '全部';
    selectedCity = '上海市';
    allCategories = ['全部', '看展', '探店', '骑行', '户外', '垂钓', '舞蹈', '健身', '桌游', '球类'];
    allCities = MockData.allCities;
  }

  List<Activity> _getFilteredActivities() {
    List<Activity> filtered = MockData.buddyActivities;

    // Filter by category
    if (selectedCategory != '全部') {
      filtered = filtered.where((activity) => activity.category == selectedCategory).toList();
    }

    // Filter by city
    if (selectedCity != '全部') {
      filtered = filtered.where((activity) => activity.location.contains(selectedCity.replaceAll('市', ''))).toList();
    }

    // Sort by selected filter
    if (selectedFilterIndex == 0) {
      // 离我最近 - sort by distance
      filtered.sort((a, b) => a.distance.compareTo(b.distance));
    } else if (selectedFilterIndex == 1) {
      // 最新发布 - sort by creation time
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return filtered;
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '筛选标签',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: allCategories.map((category) {
                      final isSelected = selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedCategory = category;
                          });
                          setState(() {
                            selectedCategory = category;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.slate100,
                            borderRadius: BorderRadius.circular(16),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: AppColors.slate200,
                                    width: 1,
                                  ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.slate600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCityFilter() {
    int selectedIndex = allCities.indexOf(selectedCity);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 300,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            const Text(
                              '选择地区',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.slate900,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, color: AppColors.slate600),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.slate200, height: 1),
                  // Scrollable Picker
                  Expanded(
                    child: ListWheelScrollView(
                      itemExtent: 50,
                      onSelectedItemChanged: (index) {
                        setModalState(() {
                          selectedIndex = index;
                        });
                      },
                      children: allCities.map((city) {
                        return Center(
                          child: Text(
                            city,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.slate600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // Confirm Button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedCity = allCities[selectedIndex];
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '确认',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
          '回频匹配',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _showCityFilter();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: selectedCity != '全部'
                    ? AppColors.primaryLight
                    : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selectedCity != '全部'
                      ? AppColors.primary
                      : AppColors.slate200,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: selectedCity != '全部'
                        ? AppColors.primary
                        : AppColors.slate600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    selectedCity.replaceAll('市', ''),
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedCity != '全部'
                          ? AppColors.primary
                          : AppColors.slate600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showCategoryFilter();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: selectedCategory != '全部'
                    ? AppColors.primaryLight
                    : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selectedCategory != '全部'
                      ? AppColors.primary
                      : AppColors.slate200,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    size: 14,
                    color: selectedCategory != '全部'
                        ? AppColors.primary
                        : AppColors.slate600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '筛选',
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedCategory != '全部'
                          ? AppColors.primary
                          : AppColors.slate600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // 筛选标签
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: List.generate(
                filters.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilterIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedFilterIndex == index
                            ? AppColors.primaryLight
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selectedFilterIndex == index
                              ? AppColors.primary
                              : AppColors.slate200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            index == 0
                                ? Icons.location_on
                                : Icons.access_time,
                            size: 14,
                            color: selectedFilterIndex == index
                                ? AppColors.primary
                                : AppColors.slate400,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            filters[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedFilterIndex == index
                                  ? AppColors.primary
                                  : AppColors.slate600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 搭子卡片列表
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: List.generate(
                _getFilteredActivities().length,
                (index) {
                  final activity = _getFilteredActivities()[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BuddyDetailPage(activity: activity),
                          ),
                        );
                      },
                      child: _buildBuddyCard(activity),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBuddyCard(Activity activity) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息头部
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(activity.userAvatar),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                activity.userName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.slate900,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.male,
                              size: 12,
                              color: AppColors.slate400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
              ],
            ),
          ),

          // 活动标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
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
          ),

          const SizedBox(height: 8),

          // 活动描述
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              activity.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.slate600,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 活动信息（时间、地点、人数）
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
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
                          '周六 19:30',
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
                      Icons.people,
                      size: 12,
                      color: AppColors.slate400,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${activity.participants}人',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 参加者头像 + 申请按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 参加者头像
                SizedBox(
                  width: 80,
                  height: 32,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(activity.userAvatar),
                          onBackgroundImageError: (exception, stackTrace) {},
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.slate200,
                          child: const Text(
                            '+2',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.slate600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 申请按钮
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.slate900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '申请加入',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
