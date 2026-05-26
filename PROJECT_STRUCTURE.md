# 知陌 (ShanDaDa) - Flutter 应用完整开发

## 项目概述
知陌是一个社区搭子应用，用户可以发起和参与各种活动（观影、看展、品鉴、饭局、音乐、骑行、户外等）。

## 项目结构

```
lib/
├── main.dart                 # 应用入口，底部导航栏管理
├── constants/
│   ├── colors.dart          # 应用颜色常量定义
│   └── mock_data.dart       # 模拟数据
├── models/
│   ├── activity.dart        # 活动数据模型
│   ├── feed.dart            # 反馈/评价数据模型
│   └── user.dart            # 用户数据模型
├── pages/
│   ├── home_page.dart       # 首页 - 活动瀑布流
│   ├── buddies_page.dart    # 找搭子页面 - 活动卡片列表
│   ├── discover_page.dart   # 发现页面 - 用户反馈流
│   ├── profile_page.dart    # 个人资料页面
│   └── publish_modal.dart   # 发布活动模态窗
├── widgets/
│   ├── activity_card.dart   # 活动卡片组件
│   ├── buddy_card.dart      # 搭子活动卡片组件
│   └── feed_card.dart       # 反馈卡片组件
└── utils/
    └── storage.dart         # 本地存储工具类
```

## 核心功能

### 1. 首页 (HomePage)
- 显示活动瀑布流（两列网格布局）
- 支持分类筛选（观影、看展、品鉴等）
- 每个活动卡片显示：图片、标题、分类、用户信息、点赞数
- 支持点赞功能

### 2. 找搭子 (BuddiesPage)
- 显示待组局的活动列表
- 支持按距离、时间、热度排序
- 活动卡片包含：标题、描述、参与人数、距离、申请按钮
- 支持申请加入活动

### 3. 发现 (DiscoverPage)
- 显示用户对活动的反馈和评价
- 每条反馈包含：用户信息、评分、标题、描述、图片、互动数据
- 支持点赞和评论

### 4. 个人资料 (ProfilePage)
- 显示用户基本信息（头像、昵称、简介）
- 显示用户统计数据（粉丝、获赞、收藏、关注）
- 时间轴显示用户发布和参与的活动
- 支持编辑资料和设置

### 5. 发布活动 (PublishModal)
- 半屏模态窗设计
- 支持输入活动标题、描述
- 支持选择活动分类
- 支持选择活动时间
- 发布成功提示

## 设计规范

### 颜色系统
- **主色**: #905FFF (高饱和优雅紫)
- **背景**: #FFFFFF (纯白)
- **中性色**: Slate 系列 (50-900)
- **分类色**: 不同分类有不同的背景和文字颜色

### 组件设计
- 圆角: 8px-24px
- 阴影: 轻微阴影，增加层次感
- 间距: 统一使用 8px 的倍数
- 字体: Roboto (英文) + Noto Sans SC (中文)

## 状态管理
- 使用 `setState` 进行本地状态管理
- 支持点赞、分类筛选、标签页切换等交互

## 本地存储
- 使用 `shared_preferences` 包
- 支持保存用户偏好、点赞记录等

## 网络图片
- 使用 Unsplash 的免费图片 API
- 所有图片通过 URL 加载
- 包含错误处理和占位符

## 依赖包
- `flutter`: Flutter SDK
- `cupertino_icons`: iOS 风格图标
- `shared_preferences`: 本地存储

## 运行项目

```bash
# 获取依赖
flutter pub get

# 运行应用
flutter run

# 构建 APK (Android)
flutter build apk

# 构建 IPA (iOS)
flutter build ios
```

## 文件说明

### models/
- **activity.dart**: 活动数据模型，包含标题、描述、分类、图片、用户信息等
- **feed.dart**: 用户反馈模型，包含评分、评价内容、图片等
- **user.dart**: 用户模型，包含个人信息、统计数据等

### constants/
- **colors.dart**: 定义应用中使用的所有颜色常量
- **mock_data.dart**: 提供模拟数据，包括活动、反馈、用户信息

### pages/
- **home_page.dart**: 首页，使用 CustomScrollView 和 SliverGrid 实现瀑布流
- **buddies_page.dart**: 找搭子页面，显示待组局的活动
- **discover_page.dart**: 发现页面，显示用户反馈
- **profile_page.dart**: 个人资料页面，包含用户信息和时间轴
- **publish_modal.dart**: 发布活动的模态窗，使用 DraggableScrollableSheet

### widgets/
- **activity_card.dart**: 活动卡片，用于首页和其他地方显示活动
- **buddy_card.dart**: 搭子活动卡片，用于找搭子页面
- **feed_card.dart**: 反馈卡片，用于发现页面

### utils/
- **storage.dart**: 本地存储工具类，封装 shared_preferences 的操作

## 主要特性

1. **响应式设计**: 适配不同屏幕尺寸
2. **流畅动画**: 使用 Flutter 内置动画
3. **本地存储**: 保存用户偏好和数据
4. **网络图片**: 从 Unsplash 加载高质量图片
5. **完整交互**: 点赞、申请、发布等功能
6. **优雅 UI**: 遵循现代设计规范

## 扩展建议

1. 集成真实后端 API
2. 添加用户认证系统
3. 实现实时消息通知
4. 添加地图功能
5. 支持图片上传
6. 添加搜索功能
7. 实现用户评分系统
8. 添加分享功能

## 注意事项

- 所有图片使用 Unsplash 的免费 API，无需认证
- 应用使用 Material Design 3
- 支持 iOS 和 Android 平台
- 代码遵循 Dart 最佳实践
- 无需外部字体，使用系统默认字体
