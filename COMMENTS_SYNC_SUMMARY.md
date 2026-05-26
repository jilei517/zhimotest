# 评论数量同步完善总结

## 📋 问题描述
发现页动态详情页面中，评论数显示与实际评论区数量不符。例如：
- 评论数显示：58 条
- 评论区实际显示：3 条

## ✅ 解决方案

### 1. **修改 Feed 模型** 
**文件**: `lib/models/feed.dart`

添加了 `commentList` 字段来存储每个动态的独立评论数据：

```dart
class Feed {
  // ... 其他字段 ...
  final List<Map<String, String>> commentList; // 评论列表

  Feed({
    // ... 其他参数 ...
    this.commentList = const [],
  });

  Feed copyWith({
    // ... 其他参数 ...
    List<Map<String, String>>? commentList,
  }) {
    return Feed(
      // ... 其他字段 ...
      commentList: commentList ?? this.commentList,
    );
  }
}
```

### 2. **更新 Mock 数据**
**文件**: `lib/constants/mock_data.dart`

为每个 Feed 添加了独立的评论数据和正确的评论数量：

```dart
static final List<Feed> feeds = [
  Feed(
    id: 'f1',
    // ... 其他字段 ...
    comments: 3,  // 评论数改为 3
    commentList: [
      {
        'userName': '张三',
        'userAvatar': 'https://picsum.photos/100/100?random=27',
        'content': '这个活动看起来很不错，我也想参加！',
        'time': '2小时前',
      },
      // ... 其他评论 ...
    ],
  ),
  // ... 其他动态 ...
];
```

### 3. **修改动态详情页面**
**文件**: `lib/pages/feed_detail_page.dart`

使用 Feed 中的 commentList 而不是硬编码的评论：

```dart
class _FeedDetailPageState extends State<FeedDetailPage> {
  late List<Map<String, String>> comments;

  @override
  void initState() {
    super.initState();
    // 从 Feed 中获取评论列表
    comments = List.from(widget.feed.commentList);
    // ... 其他初始化 ...
  }
}
```

---

## 📊 数据统计

### 评论数量调整

| 动态 ID | 原评论数 | 新评论数 | 评论者数 |
|--------|--------|--------|--------|
| f1 | 58 | 3 | 3 |
| f2 | 24 | 4 | 4 |
| f3 | 42 | 3 | 3 |
| f4 | 18 | 2 | 2 |
| f5 | 32 | 5 | 5 |
| f6 | 45 | 4 | 4 |
| f7 | 52 | 3 | 3 |
| f8 | 28 | 2 | 2 |
| f9 | 21 | 3 | 3 |

### 评论数据特点

✅ **每条动态的评论数 ≤ 5 条**
✅ **每条评论都有独立的用户信息**
✅ **评论者名字不重复**
✅ **评论内容相关且有意义**
✅ **时间戳合理递减**

---

## 🔄 评论数据结构

每条评论包含以下信息：

```dart
{
  'userName': '用户名',           // 评论者名字
  'userAvatar': '头像URL',        // 评论者头像
  'content': '评论内容',          // 评论文本
  'time': '时间戳',              // 相对时间（如"2小时前"）
}
```

---

## 📝 修改的文件

### 1. lib/models/feed.dart
- ✅ 添加 `commentList` 字段
- ✅ 更新 `copyWith` 方法

### 2. lib/constants/mock_data.dart
- ✅ 为每个 Feed 添加 `commentList` 参数
- ✅ 调整 `comments` 数量为 2-5 条
- ✅ 创建独立的评论数据（无重复）

### 3. lib/pages/feed_detail_page.dart
- ✅ 移除硬编码的评论列表
- ✅ 从 Feed 中读取 commentList
- ✅ 初始化时复制评论列表

---

## ✨ 优势

✅ **数据一致性** - 评论数与评论区数量完全匹配
✅ **独立管理** - 每个动态有自己的评论数据
✅ **易于扩展** - 可轻松添加更多评论
✅ **无重复数据** - 每条评论都是独立的
✅ **真实感** - 评论内容相关且有意义

---

## 🚀 后续优化

- [ ] 集成后端 API 获取真实评论
- [ ] 实现评论分页加载
- [ ] 添加评论点赞功能
- [ ] 实现评论删除功能
- [ ] 添加评论回复功能

---

## 📱 用户体验

现在用户在查看动态详情时：
1. 看到的评论数与评论区显示的数量一致
2. 每条动态都有独立的评论数据
3. 评论内容相关且有意义
4. 评论者信息完整且不重复

