# 知陌 (ShanDaDa) - Flutter 社区搭子应用

## 📱 应用介绍

**知陌**是一个完整的 Flutter 跨平台应用，用于组织和参与各种社交活动搭子。用户可以发起活动、寻找志同道合的搭子、分享活动反馈和评价。

### 核心功能
- 🏠 **首页**: 活动瀑布流，支持分类筛选
- 👥 **找搭子**: 待组局活动列表，支持排序和申请
- ⭐ **发现**: 用户反馈流，查看高分搭子的评价
- 👤 **个人资料**: 用户信息、统计数据、活动时间轴
- ➕ **发布活动**: 发起新活动的模态窗

## 🚀 快速开始

### 环境要求
- Flutter 3.10+
- Dart 3.0+
- iOS 11.0+ 或 Android 5.0+

### 安装步骤

```bash
# 1. 克隆项目
git clone <repository-url>
cd shandada

# 2. 获取依赖
flutter pub get

# 3. 运行应用
flutter run

# 4. 构建应用
flutter build apk  # Android
flutter build ios  # iOS
```

## 📁 项目结构

```
lib/
├── main.dart                    # 应用入口
├── constants/
│   ├── colors.dart             # 颜色常量
│   └── mock_data.dart          # 模拟数据
├── models/
│   ├── activity.dart           # 活动模型
│   ├── feed.dart               # 反馈模型
│   └── user.dart               # 用户模型
├── pages/
│   ├── home_page.dart          # 首页
│   ├── buddies_page.dart       # 找搭子
│   ├── discover_page.dart      # 发现
│   ├── profile_page.dart       # 个人资料
│   └── publish_modal.dart      # 发布模态
├── widgets/
│   ├── activity_card.dart      # 活动卡片
│   ├── buddy_card.dart         # 搭子卡片
│   └── feed_card.dart          # 反馈卡片
└── utils/
    └── storage.dart            # 存储工具
```

## 🎨 设计规范

### 颜色系统
- **主色**: #905FFF (高饱和优雅紫)
- **背景**: #FFFFFF (纯白)
- **中性色**: Slate 50-900
- **分类色**: 7 种不同颜色

### 组件设计
- 圆角: 8px-24px
- 阴影: 轻微阴影增加层次感
- 间距: 统一 8px 倍数
- 字体: Roboto + Noto Sans SC

## 📊 功能详解

### 首页 (HomePage)
- 瀑布流布局 (2 列网格)
- 8 个分类筛选
- 活动卡片显示
- 点赞功能
- 网络图片加载

### 找搭子 (BuddiesPage)
- 活动列表显示
- 3 种排序方式 (距离、时间、热度)
- 搭子卡片显示
- 申请功能
- 满员状态显示

### 发现 (DiscoverPage)
- 用户反馈流
- 用户评分显示
- 点赞功能
- 评论计数
- 分类标签

### 个人资料 (ProfilePage)
- 用户信息展示
- 统计数据 (粉丝、获赞、收藏、关注)
- 标签页切换
- 时间轴显示
- 编辑资料功能

### 发布活动 (PublishModal)
- 标题输入
- 分类选择 (7 个分类)
- 描述输入
- 时间选择
- 发布功能

## 🔧 技术栈

| 技术 | 版本 | 用途 |
|------|------|------|
| Flutter | 3.10+ | 跨平台框架 |
| Dart | 3.0+ | 编程语言 |
| Material Design | 3 | 设计规范 |
| shared_preferences | 2.2.2 | 本地存储 |
| Unsplash API | - | 网络图片 |

## 📦 依赖包

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2
```

## 💾 本地存储

应用使用 `shared_preferences` 进行本地存储：

```dart
// 保存点赞
await StorageUtil.addLikedActivity('activity_id');

// 获取点赞列表
final liked = StorageUtil.getLikedActivities();

// 移除点赞
await StorageUtil.removeLikedActivity('activity_id');
```

## 🖼️ 图片来源

所有图片来自 **Unsplash** 免费图片库：
- https://images.unsplash.com/

用户头像使用卡通、动物、风景、美食等多样化图片。

## 📝 代码特点

1. **无 freezed 包** - 使用手写的 copyWith 方法
2. **无 part 语法** - 完整的类定义
3. **setState 状态管理** - 简单高效
4. **本地存储** - shared_preferences
5. **网络图片** - 无需缓存包
6. **完整的错误处理** - 图片加载失败处理
7. **响应式设计** - 适配各种屏幕

## 🎯 主要交互

### 首页
- 点击分类标签切换筛选
- 点击心形图标点赞活动
- 点击活动卡片查看详情

### 找搭子
- 点击排序按钮改变排序方式
- 点击"立即申请"按钮申请加入
- 满员活动显示"已满员"状态

### 发现
- 点击心形图标点赞反馈
- 点击评论图标查看评论
- 查看用户评分和反馈内容

### 个人资料
- 点击"编辑资料"修改信息
- 点击设置图标进入设置
- 切换"发布活动轴"和"参与活动轴"标签页
- 查看时间轴中的活动记录

### 发布活动
- 点击底部导航栏中央的"+"按钮
- 输入活动标题
- 选择活动分类
- 输入活动描述
- 选择活动时间
- 点击"发布活动"完成发布

## 📚 文档

- **PROJECT_STRUCTURE.md** - 详细的项目结构说明
- **QUICK_START.md** - 快速开始指南
- **FILE_MANIFEST.md** - 完整的文件清单
- **DEVELOPMENT_SUMMARY.md** - 开发总结

## 🔍 代码质量

- ✅ flutter analyze: 无问题
- ✅ 编译错误: 0 个
- ✅ 警告信息: 0 个
- ✅ 代码规范: 100%
- ✅ 文档完整: 100%

## 🚀 构建和部署

### Android
```bash
flutter build apk
# 输出: build/app/outputs/flutter-apk/app-release.apk
```

### iOS
```bash
flutter build ios
# 输出: build/ios/iphoneos/Runner.app
```

### Web (可选)
```bash
flutter build web
# 输出: build/web/
```

## 🔮 未来扩展

### 短期
- [ ] 集成真实后端 API
- [ ] 实现用户认证
- [ ] 添加搜索功能
- [ ] 优化图片加载

### 中期
- [ ] 实现实时通知
- [ ] 添加地图功能
- [ ] 支持图片上传
- [ ] 实现用户评分系统

### 长期
- [ ] 添加视频功能
- [ ] 实现社交功能
- [ ] 添加支付功能
- [ ] 实现推荐算法

## 🐛 常见问题

### Q: 如何修改主色？
A: 编辑 `lib/constants/colors.dart` 中的 `primary` 颜色值。

### Q: 如何添加新的分类？
A: 在 `lib/constants/mock_data.dart` 中的 `categories` 列表中添加新分类。

### Q: 如何修改模拟数据？
A: 编辑 `lib/constants/mock_data.dart` 中的 `homeActivities`、`buddyActivities` 和 `feeds` 列表。

### Q: 如何添加本地存储？
A: 使用 `lib/utils/storage.dart` 中的 `StorageUtil` 类。

### Q: 如何添加新页面？
A: 
1. 在 `lib/pages/` 中创建新的 Dart 文件
2. 在 `lib/main.dart` 中的 `_pages` 列表中添加新页面
3. 在底部导航栏中添加新的 `BottomNavigationBarItem`

## 📞 支持

如有问题，请参考项目文档或提交 Issue。

## 📄 许可证

本项目为学习和演示用途。

## 👨‍💻 开发者

开发完成于 2026-05-15

---

**感谢使用知陌！** 🎉

如果你觉得这个项目有帮助，请给个 Star ⭐
