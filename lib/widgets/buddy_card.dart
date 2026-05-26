import 'package:flutter/material.dart';
import 'package:shandada/constants/colors.dart';
import 'package:shandada/models/activity.dart';

class BuddyCard extends StatefulWidget {
  final Activity activity;
  final VoidCallback onApply;

  const BuddyCard({
    super.key,
    required this.activity,
    required this.onApply,
  });

  @override
  State<BuddyCard> createState() => _BuddyCardState();
}

class _BuddyCardState extends State<BuddyCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
      },
      onExit: (_) {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.02).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.activity.isFull
                  ? AppColors.slate200
                  : AppColors.primaryLight,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.activity.isFull
                    ? Colors.black.withValues(alpha: 0.08)
                    : AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头部 - 分类和状态
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${widget.activity.categoryEmoji} ${widget.activity.category}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    if (widget.activity.isFull)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '已满员',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // 标题
                Text(
                  widget.activity.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate900,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),

                // 描述
                Text(
                  widget.activity.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.slate500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),

                // 信息行 - 距离和参与人数
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.activity.distance}km',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.slate500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.people,
                      size: 14,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.activity.participants}人已参加',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // 底部 - 头像和按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 头像堆叠
                    SizedBox(
                      width: 80,
                      height: 24,
                      child: Stack(
                        children: [
                          for (int i = 0;
                              i < (widget.activity.participants > 3 ? 2 : widget.activity.participants);
                              i++)
                            Positioned(
                              left: i * 14.0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.white,
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundImage:
                                      NetworkImage(widget.activity.userAvatar),
                                  onBackgroundImageError:
                                      (exception, stackTrace) {},
                                ),
                              ),
                            ),
                          if (widget.activity.participants > 2)
                            Positioned(
                              left: 28,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.slate100,
                                child: Text(
                                  '+${widget.activity.participants - 2}',
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.slate500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // 申请按钮
                    GestureDetector(
                      onTap: widget.activity.isFull ? null : widget.onApply,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: widget.activity.isFull
                              ? null
                              : AppColors.primaryGradient,
                          color: widget.activity.isFull
                              ? AppColors.slate200
                              : null,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: widget.activity.isFull
                              ? null
                              : [
                                  BoxShadow(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                        child: Text(
                          widget.activity.isFull ? '已满员' : '立即申请',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.activity.isFull
                                ? AppColors.slate500
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
