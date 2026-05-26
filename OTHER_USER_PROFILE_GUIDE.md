# 他人个人主页 - 使用指南

## 📱 功能概览

新增的他人个人主页包含以下功能：

### 用户信息部分
- ✅ **头像** - 圆形头像，带白色边框和阴影
- ✅ **昵称** - 用户名称
- ✅ **签名** - 用户个人签名
- ✅ **关注按钮** - 关注/已关注状态切换

### 统计信息
- ⭐ **评分** - 用户评分
- 👥 **粉丝** - 粉丝数量
- 👤 **关注** - 关注数量

### 活动列表
- 📅 **正在发起的活动** - 用户当前发起的活动
- 📜 **历史发起的活动** - 用户过去发起的活动

---

## 🚀 快速开始

### 1. 导入必要的类

```dart
import 'package:shandada/models/user_profile.dart';
import 'package:shandada/pages/other_user_profile_page.dart';
import 'package:shandada/models/activity.dart';
```

### 2. 创建用户数据

```dart
final userProfile = UserProfile(
  id: 'user_123',
  name: 'Molly',
  avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&q=80',
  signature: '当代艺术爱好者，寻找周末一起黑暗的艺术搭子',
  rating: 4.8,
  followers: 256,
  following: 128,
  isFollowed: false,
  activitiesInitiated: ['activity_1', 'activity_2'],
  activitiesHistory: ['activity_3', 'activity_4', 'activity_5'],
);
```

### 3. 准备活动数据

```dart
final initiatedActivities = [
  Activity(
    id: 'activity_1',
    title: '当代艺术私享展',
    description: '周末去看当代艺术展...',
    category: '音展',
    categoryEmoji: '🎨',
    imageUrl: 'https://...',
    userName: 'Molly',
    userAvatar: 'https://...',
    likes: 142,
    participants: 2,
    distance: 0.8,
    location: '上海·浦东',
    createdAt: DateTime.now(),
  ),
  // 更多活动...
];

final historyActivities = [
  // 历史活动...
];
```

### 4. 打开他人主页

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => OtherUserProfilePage(
      userProfile: userProfile,
      initiatedActivities: initiatedActivities,
      historyActivities: historyActivities,
    ),
  ),
);
```

---

## 📁 文件位置

```
lib/
├── models/
│   └── user_profile.dart          # 用户资料模型
└── pages/
    └── other_user_profile_page.dart # 他人个人主页
```

---

## 🎨 UI 布局

### 页面结构

```
┌─────────────────────────────────┐
│ ← [返回]                        │  ← 返回按钮
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐│
│  │  [渐变背景]                 ││
│  │                             ││
│  │      [👤 头像]              ││
│  │                             ││
│  │      Molly                  ││
│  │   当代艺术爱好者...          ││
│  │                             ││
│  │  ⭐ 4.8  👥 256  👤 128    ││
│  │                             ││
│  │  [关注按钮]                 ││
│  │                             ││
│  └─────────────────────────────┘│
├─────────────────────────────────┤
│ 正在发起  |  历史发起           │  ← 标签页
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐│
│  │  [活动图片]                 ││
│  │  🎨 音展                    ││
│  │  当代艺术私享展              ││
│  │  📅 2026-05-17              ││
│  │  📍 上海·浦东               ││
│  │  👥 2人参加                 ││
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │  [活动图片]                 ││
│  │  ...                        ││
│  └─────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

---

## 🎯 功能详解

### 1. 用户信息卡片

**包含内容**:
- 圆形头像（80x80）
- 用户昵称
- 个人签名
- 统计信息（评分、粉丝、关注）
- 关注按钮

**样式特点**:
- 渐变背景（紫色）
- 白色文字
- 圆角设计
- 阴影效果

### 2. 标签页切换

**功能**:
- 切换"正在发起"和"历史发起"
- 下划线指示当前标签
- 平滑过渡

### 3. 活动列表

**每个活动卡片包含**:
- 活动图片
- 分类标签
- 活动标题
- 活动时间
- 活动地点
- 参加人数

**空状态**:
- 显示相应的图标和提示文字

---

## 💻 代码示例

### 从伙伴详情页跳转到他人主页

```dart
// 在 buddy_detail_page.dart 中
GestureDetector(
  onTap: () {
    // 创建用户资料
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

    // 跳转到他人主页
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
  },
  child: Text(widget.activity.userName),
)
```

### 从活动详情页跳转到他人主页

```dart
// 在 activity_detail_page.dart 中
GestureDetector(
  onTap: () {
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
  },
  child: CircleAvatar(
    backgroundImage: NetworkImage(widget.activity.userAvatar),
  ),
)
```

---

## 🔧 自定义

### 修改头像大小

```dart
// 在 _buildStatItem 中修改
Container(
  width: 100,  // 修改这里
  height: 100,
  ...
)
```

### 修改渐变颜色

```dart
// 在 build 方法中修改
gradient: LinearGradient(
  colors: [
    Colors.blue.withValues(alpha: 0.8),  // 修改颜色
    Colors.blue.withValues(alpha: 0.4),
  ],
  ...
)
```

### 修改活动卡片样式

```dart
// 在 _buildActivityCard 中修改
Container(
  margin: const EdgeInsets.only(bottom: 12),
  decoration: BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(20),  // 修改圆角
    ...
  ),
  ...
)
```

---

## 📊 数据结构

### UserProfile 模型

```dart
class UserProfile {
  final String id;              // 用户 ID
  final String name;            // 昵称
  final String avatar;          // 头像 URL
  final String signature;       // 签名
  final double rating;          // 评分
  final int followers;          // 粉丝数
  final int following;          // 关注数
  final bool isFollowed;        // 是否已关注
  final List<String> activitiesInitiated;  // 正在发起的活动 ID
  final List<String> activitiesHistory;    // 历史发起的活动 ID
}
```

---

## 🎯 使用场景

### 场景 1: 从活动详情页查看发起者信息

```
活动详情页 → 点击用户名/头像 → 他人主页
```

### 场景 2: 从伙伴列表查看伙伴详情

```
伙伴列表 → 点击伙伴卡片 → 伙伴详情页 → 点击用户名 → 他人主页
```

### 场景 3: 从评论区查看评论者信息

```
评论区 → 点击评论者头像 → 他人主页
```

---

## ✨ 特色功能

### 1. 关注功能
- 点击关注按钮切换关注状态
- 按钮样式随状态改变
- 实时更新粉丝数

### 2. 标签页切换
- 平滑的标签页切换
- 下划线指示当前标签
- 活动列表动态更新

### 3. 空状态处理
- 当没有活动时显示提示
- 相应的图标和文字
- 友好的用户体验

### 4. 响应式设计
- 适配各种屏幕尺寸
- 流畅的滚动体验
- 优雅的过渡动画

---

## 🔄 后续优化

### 短期
- [ ] 添加私信功能
- [ ] 添加举报功能
- [ ] 添加屏蔽功能

### 中期
- [ ] 实现真实的关注功能
- [ ] 从后端加载用户数据
- [ ] 实现活动分页加载

### 长期
- [ ] 添加用户评价功能
- [ ] 实现用户推荐系统
- [ ] 添加用户认证标签

---

## 📞 常见问题

### Q: 如何修改用户签名？
A: 修改 `UserProfile` 的 `signature` 字段

### Q: 如何添加更多活动？
A: 向 `initiatedActivities` 或 `historyActivities` 列表添加 `Activity` 对象

### Q: 如何实现真实的关注功能？
A: 在关注按钮的 `onTap` 回调中调用 API

### Q: 如何从后端加载数据？
A: 使用 Provider 或其他状态管理库从 API 获取数据

---

## 📚 相关文件

- `lib/models/user_profile.dart` - 用户资料模型
- `lib/pages/other_user_profile_page.dart` - 他人个人主页
- `lib/models/activity.dart` - 活动模型
- `lib/constants/colors.dart` - 颜色定义

---

**版本**: 1.0.0
**最后更新**: 2026-05-18
**维护者**: Kiro AI
