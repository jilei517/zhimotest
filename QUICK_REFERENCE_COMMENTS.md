# 评论数据快速参考

## 🎯 核心改动

| 项目 | 原状态 | 新状态 |
|------|--------|--------|
| 评论数范围 | 18-58 条 | 2-5 条 |
| 评论数据 | 硬编码 | 动态绑定 |
| 数据一致性 | ❌ 不一致 | ✅ 一致 |
| 评论重复 | ❌ 有重复 | ✅ 无重复 |

---

## 📊 评论数量对照表

```
f1: 3 条评论  (张三、李四、王五)
f2: 4 条评论  (赵六、孙七、周八、吴九)
f3: 3 条评论  (郑十、陈十一、刘十二)
f4: 2 条评论  (杨十三、何十四)
f5: 5 条评论  (曾十五、傅十六、彭十七、苏十八、卢十九)
f6: 4 条评论  (朱二十、徐二十一、韦二十二、唐二十三)
f7: 3 条评论  (侯二十四、邓二十五、郭二十六)
f8: 2 条评论  (龚二十七、贺二十八)
f9: 3 条评论  (韩二十九、冯三十、白三十一)
```

---

## 🔧 代码位置

### Feed 模型
**文件**: `lib/models/feed.dart`
- 第 15 行: `final List<Map<String, String>> commentList;`
- 第 32 行: `this.commentList = const [],`

### Mock 数据
**文件**: `lib/constants/mock_data.dart`
- 第 1738-1938 行: feeds 列表定义
- 每个 Feed 都有 `commentList` 参数

### 详情页面
**文件**: `lib/pages/feed_detail_page.dart`
- 第 35 行: `late List<Map<String, String>> comments;`
- 第 42 行: `comments = List.from(widget.feed.commentList);`

---

## 💡 使用示例

### 添加新评论
```dart
comments.add({
  'userName': '新用户',
  'userAvatar': 'https://picsum.photos/100/100?random=56',
  'content': '新评论内容',
  'time': '刚刚',
});
```

### 获取评论数
```dart
int commentCount = widget.feed.comments;
int actualComments = widget.feed.commentList.length;
```

### 遍历评论
```dart
for (var comment in widget.feed.commentList) {
  print('${comment['userName']}: ${comment['content']}');
}
```

---

## ✅ 验证清单

- ✅ 每个 Feed 都有 commentList
- ✅ comments 数量 ≤ 5
- ✅ 评论数与评论区数量一致
- ✅ 评论者名字不重复
- ✅ 评论内容相关有意义
- ✅ 无编译错误

---

## 🎨 评论显示格式

```
┌─────────────────────────────┐
│ 👤 用户名                    │
│ 评论内容                     │
│ 时间戳                       │
└─────────────────────────────┘
```

---

## 📱 用户看到的效果

**发现页**:
- 动态卡片显示评论数（2-5 条）

**详情页**:
- 评论区显示对应数量的评论
- 每条评论有用户头像、名字、内容、时间
- 可以添加新评论

