import 'package:flutter/material.dart';
import 'package:shandada/constants/colors.dart';

class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({super.key});

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
          '用户需知',
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
              '知陌用户需知',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '更新日期：2024年1月1日\n生效日期：2024年1月1日',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.slate500,
              ),
            ),
            SizedBox(height: 24),
            _SectionTitle('一、服务说明'),
            _SectionContent(
              '知陌是一款社交活动配对平台，致力于帮助用户找到志同道合的活动伙伴。用户在使用本平台前，请仔细阅读本用户需知。',
            ),
            SizedBox(height: 16),
            _SectionTitle('二、用户行为规范'),
            _SectionContent(
              '1. 用户应遵守中华人民共和国相关法律法规，不得发布违法、违规内容。\n\n'
              '2. 用户不得发布虚假信息、欺诈内容或恶意骚扰他人。\n\n'
              '3. 用户不得发布涉及色情、暴力、歧视等不良内容。\n\n'
              '4. 用户应尊重他人隐私，不得未经授权传播他人个人信息。\n\n'
              '5. 用户不得利用本平台从事任何商业推广或广告活动。',
            ),
            SizedBox(height: 16),
            _SectionTitle('三、账号管理'),
            _SectionContent(
              '1. 用户需对自己的账号安全负责，妥善保管登录凭证。\n\n'
              '2. 如发现账号被盗用，请立即联系客服处理。\n\n'
              '3. 平台有权对违规账号进行封禁处理。',
            ),
            SizedBox(height: 16),
            _SectionTitle('四、内容版权'),
            _SectionContent(
              '1. 用户发布的内容版权归用户所有，但用户授权平台在全球范围内免费使用。\n\n'
              '2. 用户不得发布侵犯他人知识产权的内容。',
            ),
            SizedBox(height: 16),
            _SectionTitle('五、免责声明'),
            _SectionContent(
              '1. 平台不对用户之间的线下活动安全负责，用户参与活动需自行评估风险。\n\n'
              '2. 平台不对用户发布的内容真实性作出保证。\n\n'
              '3. 因不可抗力导致的服务中断，平台不承担责任。',
            ),
            SizedBox(height: 16),
            _SectionTitle('六、协议修改'),
            _SectionContent(
              '平台有权根据需要修改本协议，修改后将在平台内公告。继续使用平台即视为同意修改后的协议。',
            ),
            SizedBox(height: 16),
            _SectionTitle('七、联系我们'),
            _SectionContent(
              '如有任何疑问，请通过"帮助与反馈"功能联系我们。',
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
