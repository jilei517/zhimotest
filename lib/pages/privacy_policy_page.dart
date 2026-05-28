import 'package:flutter/material.dart';
import 'package:shandada/constants/colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.slate600,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          '隐私协议',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.slate900,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '知陌隐私协议',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '更新日期：2026年5月1日\n生效日期：2026年5月1日',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.slate500,
              ),
            ),
            SizedBox(height: 24),
            _SectionTitle('一、信息收集'),
            _SectionContent(
              '我们收集以下类型的信息：\n\n'
              '1. 账号信息：昵称、头像、性别、年龄等您主动填写的信息。\n\n'
              '2. 设备信息：设备型号、操作系统版本、唯一设备标识符等。\n\n'
              '3. 使用信息：您在平台上的操作记录、浏览记录等。\n\n'
              '4. 位置信息：在您授权的情况下，获取您的地理位置信息。\n\n'
              '5. 相机和相册：在您授权的情况下，用于上传头像和活动图片。',
            ),
            SizedBox(height: 16),
            _SectionTitle('二、信息使用'),
            _SectionContent(
              '我们使用收集的信息用于：\n\n'
              '1. 提供、维护和改善我们的服务。\n\n'
              '2. 为您匹配合适的活动伙伴。\n\n'
              '3. 发送服务通知和更新。\n\n'
              '4. 防范欺诈和保障平台安全。\n\n'
              '5. 分析使用情况以优化用户体验。',
            ),
            SizedBox(height: 16),
            _SectionTitle('三、信息共享'),
            _SectionContent(
              '我们不会将您的个人信息出售给第三方。在以下情况下可能共享信息：\n\n'
              '1. 经您明确同意。\n\n'
              '2. 依法配合政府机关的要求。\n\n'
              '3. 为保护平台、用户或公众的合法权益。',
            ),
            SizedBox(height: 16),
            _SectionTitle('四、信息存储'),
            _SectionContent(
              '1. 您的信息存储在中华人民共和国境内的服务器上。\n\n'
              '2. 我们采用加密等安全措施保护您的信息。\n\n'
              '3. 账号注销后，我们将在合理期限内删除您的个人信息。',
            ),
            SizedBox(height: 16),
            _SectionTitle('五、您的权利'),
            _SectionContent(
              '您对自己的个人信息享有以下权利：\n\n'
              '1. 查阅权：您可以查看自己的个人信息。\n\n'
              '2. 更正权：您可以修改不准确的个人信息。\n\n'
              '3. 删除权：您可以申请删除个人信息。\n\n'
              '4. 撤回同意：您可以随时撤回对信息收集的授权。',
            ),
            SizedBox(height: 16),
            _SectionTitle('六、未成年人保护'),
            _SectionContent(
              '本平台不面向18岁以下未成年人。如发现未成年人注册账号，我们将及时处理。',
            ),
            SizedBox(height: 16),
            _SectionTitle('七、隐私政策更新'),
            _SectionContent(
              '我们可能会不时更新本隐私政策。更新后将在平台内通知您，继续使用即视为同意更新后的政策。',
            ),
            SizedBox(height: 16),
            _SectionTitle('八、联系我们'),
            _SectionContent(
              '如对本隐私政策有任何疑问，请通过"帮助与反馈"功能联系我们。',
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.slate900,
        ),
      ),
    );
  }
}

class _SectionContent extends StatelessWidget {
  final String text;
  const _SectionContent(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.slate600,
        height: 1.8,
      ),
    );
  }
}
