# 他人主页集成示例

## 🔗 集成方式

### 方式 1: 从活动详情页跳转

在 `activity_detail_page.dart` 中，修改用户卡片部分：

```dart
// 找到用户卡片的 Row 部分
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
```

然后在类中添加导航方法：

```dart
void _navigateToUserProfile() {
  final userProfile = UserProfile(
    id: widget.activity.id,
    name: widget.activity.userName,
    avatar: widget.activity.userAvatar,
    signature: '这是用户签名',
    rating: 4.8,
    followers: 256,
    following: 128,
    isFollowed: false,
    activitiesInitiated: [],
    activitiesHistory: [],
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtherUserProfilePage(
        userProfile: userProfile,
        initiatedActivities: [],
        historyActivities: [],
      ),
    ),
  );
}
```

---

### 方式 2: 从伙伴详情页跳转

在 `buddy_detail_page.dart` 中，修改用户卡片部分（同上）

---

### 方式 3: 从评论区跳转

在评论列表中，修改评论者头像部分：

```dart
GestureDetector(
  onTap: () {
    _navigateToUserProfile(comment['userName']!, comment['userAvatar']!);
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
```

然后添加导航方法：

```dart
void _navigateToUserProfile(String userName, String userAvatar) {
  final userProfile = UserProfile(
    id: 'user_${DateTime.now().millisecondsSinceEpoch}',
    name: userName,
    avatar: userAvatar,
    signature: '这是用户签名',
    rating: 4.5,
    followers: 128,
    following: 64,
    isFollowed: false,
    activitiesInitiated: [],
    activitiesHistory: [],
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtherUserProfilePage(
        userProfile: userProfile,
        initiatedActivities: [],
        historyActivities: [],
      ),
    ),
  );
}
```

---

## 📦 完整示例代码

### 在 activity_detail_page.dart 中的完整实现

```dart
import 'package:shandada/models/user_profile.dart';
import 'package:shandada/pages/other_user_profile_page.dart';

// ... 其他导入 ...

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  // ... 其他代码 ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... AppBar 等 ...
      body: ListView(
        // ... 其他内容 ...
        children: [
          // 用户卡片
          Container(
            // ... 样式 ...
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _navigateToUserProfile,
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
                          onTap: _navigateToUserProfile,
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
                // ... 参加按钮 ...
              ],
            ),
          ),
          // ... 其他内容 ...
        ],
      ),
    );
  }

  void _navigateToUserProfile() {
    final userProfile = UserProfile(
      id: widget.activity.id,
      name: widget.activity.userName,
      avatar: widget.activity.userAvatar,
      signature: '这是用户签名',
      rating: 4.8,
      followers: 256,
      following: 128,
      isFollowed: false,
      activitiesInitiated: [],
      activitiesHistory: [],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
          userProfile: userProfile,
          initiatedActivities: [],
          historyActivities: [],
        ),
      ),
    );
  }

  // ... 其他方法 ...
}
```

---

## 🎯 集成步骤

### 步骤 1: 导入必要的类

在文件顶部添加：

```dart
import 'package:shandada/models/user_profile.dart';
import 'package:shandada/pages/other_user_profile_page.dart';
```

### 步骤 2: 添加导航方法

在 State 类中添加 `_navigateToUserProfile()` 方法

### 步骤 3: 修改可点击元素

将用户头像、用户名等元素包装在 `GestureDetector` 中

### 步骤 4: 测试

运行应用并点击用户头像或用户名，应该能跳转到他人主页

---

## 🔄 数据流

```
活动详情页
    ↓
点击用户头像/用户名
    ↓
创建 UserProfile 对象
    ↓
导航到 OtherUserProfilePage
    ↓
显示他人主页
```

---

## 💡 最佳实践

### 1. 创建可复用的导航方法

```dart
void _navigateToUserProfile(String userId, String userName, String avatar) {
  final userProfile = UserProfile(
    id: userId,
    name: userName,
    avatar: avatar,
    signature: '这是用户签名',
    rating: 4.8,
    followers: 256,
    following: 128,
    isFollowed: false,
    activitiesInitiated: [],
    activitiesHistory: [],
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtherUserProfilePage(
        userProfile: userProfile,
        initiatedActivities: [],
        historyActivities: [],
      ),
    ),
  );
}
```

### 2. 从 Provider 获取数据

```dart
void _navigateToUserProfile() {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  
  // 从 Provider 获取用户数据
  final userProfile = userProvider.getUserProfile(widget.activity.id);
  
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtherUserProfilePage(
        userProfile: userProfile,
        initiatedActivities: userProvider.getUserActivities(widget.activity.id),
        historyActivities: userProvider.getUserHistoryActivities(widget.activity.id),
      ),
    ),
  );
}
```

### 3. 处理加载状态

```dart
void _navigateToUserProfile() async {
  // 显示加载指示器
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  try {
    // 从 API 获取用户数据
    final userProfile = await _fetchUserProfile(widget.activity.id);
    final activities = await _fetchUserActivities(widget.activity.id);

    // 关闭加载指示器
    Navigator.pop(context);

    // 导航到他人主页
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
          userProfile: userProfile,
          initiatedActivities: activities['initiated'] ?? [],
          historyActivities: activities['history'] ?? [],
        ),
      ),
    );
  } catch (e) {
    // 关闭加载指示器
    Navigator.pop(context);

    // 显示错误信息
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('加载失败: $e')),
    );
  }
}
```

---

## 📝 注意事项

1. **导入路径** - 确保导入路径正确
2. **数据完整性** - 确保 UserProfile 的所有字段都有值
3. **图片加载** - 使用有效的图片 URL
4. **错误处理** - 添加适当的错误处理
5. **性能优化** - 考虑使用缓存来避免重复加载

---

**版本**: 1.0.0
**最后更新**: 2026-05-18
