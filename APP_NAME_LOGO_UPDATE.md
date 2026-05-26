# 应用名称和 Logo 更新总结

## 完成的任务

### 1. 应用名称改为"知陌" ✓

#### iOS 配置修改
- **文件**: `ios/Runner/Info.plist`
- **修改**: 
  - `CFBundleDisplayName`: `Shandada` → `知陌`
  - `CFBundleName`: `shandada` (保持不变，用于内部标识)

#### Android 配置修改
- **文件**: `android/app/src/main/AndroidManifest.xml`
- **修改**: 
  - `android:label`: `shandada` → `知陌`

### 2. Logo 更新为 logo.jpg ✓

#### 使用 flutter_launcher_icons 自动生成
- **文件**: `pubspec.yaml`
- **添加依赖**: `flutter_launcher_icons: ^0.13.1`
- **配置**:
  ```yaml
  flutter_launcher_icons:
    image_path: "assets/images/logo.jpg"
    ios: true
    android: true
  ```

#### 生成的 Icon 位置
- **iOS**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/` (所有尺寸)
- **Android**: 
  - `android/app/src/main/res/mipmap-mdpi/ic_launcher.png`
  - `android/app/src/main/res/mipmap-hdpi/ic_launcher.png`
  - `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png`
  - `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png`
  - `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png`

## 修改的文件列表

1. ✅ `ios/Runner/Info.plist` - iOS 应用名称
2. ✅ `android/app/src/main/AndroidManifest.xml` - Android 应用名称
3. ✅ `pubspec.yaml` - 添加 flutter_launcher_icons 配置
4. ✅ `ios/Runner/Assets.xcassets/AppIcon.appiconset/` - iOS icons (自动生成)
5. ✅ `android/app/src/main/res/mipmap-*/` - Android icons (自动生成)

## 验证方法

1. **应用名称**: 
   - iOS: 在 iPhone 主屏幕上查看应用名称，应显示"知陌"
   - Android: 在 Android 主屏幕上查看应用名称，应显示"知陌"

2. **Logo**: 
   - iOS: 应用 icon 应显示 logo.jpg 的内容
   - Android: 应用 icon 应显示 logo.jpg 的内容

## 下一步

需要重新构建应用才能看到完整的效果：

### iOS
```bash
flutter clean
flutter pub get
flutter run -d "4FDA7871-E3A5-430E-ADD2-3B423CAB6C2E"
```

### Android
```bash
flutter clean
flutter pub get
flutter run -d <android-device-id>
```

或者直接在 Xcode/Android Studio 中重新构建。

## 技术细节

- `flutter_launcher_icons` 会自动生成所有必需的 icon 尺寸
- iOS 需要的尺寸: 20x20, 29x29, 40x40, 60x60, 76x76, 83.5x83.5, 1024x1024
- Android 需要的尺寸: mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi
- 源图片 (logo.jpg) 应该是正方形，建议至少 1024x1024 像素
