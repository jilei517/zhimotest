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
          '用户协议（EULA）',
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
              '知陌用户协议（最终用户许可协议 EULA）',
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
            SizedBox(height: 16),

            // 年龄限制警告框
            _AgeWarningBox(),

            SizedBox(height: 24),
            _SectionTitle('一、年龄要求（重要）'),
            _SectionContent(
              '本应用仅面向年满 18 周岁及以上的成年用户。\n\n'
              '使用本应用即表示您确认您已年满 18 周岁。如您未满 18 周岁，请立即停止使用本应用并卸载。\n\n'
              '我们不会故意收集未成年人的个人信息。如发现未成年人注册账号，我们将立即删除相关账号及数据。',
            ),
            SizedBox(height: 16),
            _SectionTitle('二、服务说明'),
            _SectionContent(
              '知陌是一款面向成年人的社交活动配对平台，致力于帮助用户找到志同道合的活动伙伴。用户在使用本平台前，请仔细阅读本用户协议。',
            ),
            SizedBox(height: 16),
            _SectionTitle('三、内容规范——零容忍政策'),
            _ZeroToleranceContent(),
            SizedBox(height: 16),
            _SectionTitle('四、用户行为规范'),
            _SectionContent(
              '1. 用户应遵守中华人民共和国相关法律法规，不得发布违法、违规内容。\n\n'
              '2. 用户不得发布虚假信息、欺诈内容或恶意骚扰他人。\n\n'
              '3. 用户应尊重他人隐私，不得未经授权传播他人个人信息。\n\n'
              '4. 用户不得利用本平台从事任何商业推广或广告活动。\n\n'
              '5. 用户不得冒充他人或虚构身份。',
            ),
            SizedBox(height: 16),
            _SectionTitle('五、内容审核与举报机制'),
            _SectionContent(
              '1. 用户可通过帖子右上角的"更多"按钮举报不良内容。\n\n'
              '2. 用户可屏蔽或拉黑不当用户，被屏蔽用户的内容将不再显示。\n\n'
              '3. 用户可立即从动态流中移除不想看到的内容。\n\n'
              '4. 我们承诺在收到举报后 24 小时内处理，删除违规内容并封禁违规用户。\n\n'
              '5. 如需直接联系我们举报违规内容，请发送邮件至：zhimo_support@163.com',
            ),
            SizedBox(height: 16),
            _SectionTitle('六、账号管理'),
            _SectionContent(
              '1. 用户需对自己的账号安全负责，妥善保管登录凭证。\n\n'
              '2. 如发现账号被盗用，请立即联系客服处理。\n\n'
              '3. 平台有权对违规账号进行封禁处理，情节严重者将永久封禁。\n\n'
              '4. 用户可随时在"设置"中注销账号，注销后所有数据将被删除。',
            ),
            SizedBox(height: 16),
            _SectionTitle('七、内容版权'),
            _SectionContent(
              '1. 用户发布的内容版权归用户所有，但用户授权平台在全球范围内免费使用。\n\n'
              '2. 用户不得发布侵犯他人知识产权的内容。',
            ),
            SizedBox(height: 16),
            _SectionTitle('八、免责声明'),
            _SectionContent(
              '1. 平台不对用户之间的线下活动安全负责，用户参与活动需自行评估风险。\n\n'
              '2. 平台不对用户发布的内容真实性作出保证。\n\n'
              '3. 因不可抗力导致的服务中断，平台不承担责任。',
            ),
            SizedBox(height: 16),
            _SectionTitle('九、协议修改'),
            _SectionContent(
              '平台有权根据需要修改本协议，修改后将在平台内公告。继续使用平台即视为同意修改后的协议。',
            ),
            SizedBox(height: 16),
            _SectionTitle('十、联系我们'),
            _SectionContent(
              '如需举报违规内容、不当用户，或有任何疑问，请通过以下方式联系我们：\n\n'
              '📧 邮箱：zhimo_support@163.com\n\n'
              '我们承诺在 24 小时内响应所有举报，并在确认违规后立即采取行动。',
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _AgeWarningBox extends StatelessWidget {
  const _AgeWarningBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '年龄限制：仅限 18 岁以上',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '本应用包含面向成年人的内容，未满 18 周岁的用户禁止使用。',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
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

class _ZeroToleranceContent extends StatelessWidget {
  const _ZeroToleranceContent();

  @override
  Widget build(BuildContext context) {
    const highlightStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Color(0xFFDC2626), // 红色加粗
      height: 1.8,
    );
    const normalStyle = TextStyle(
      fontSize: 14,
      color: AppColors.slate600,
      height: 1.8,
    );

    final items = [
      ('色情、淫秽、性暗示内容', ''),
      ('暴力、血腥、恐怖内容', ''),
      ('骚扰、霸凌、威胁、仇恨言论', ''),
      ('歧视性内容', '（基于种族、性别、宗教、国籍、残疾等）'),
      ('虚假信息、诈骗、欺诈内容', ''),
      ('侵犯他人隐私的内容', '（未经授权传播他人个人信息、照片等）'),
      ('违反中华人民共和国及用户所在地法律法规的内容', ''),
      ('任何形式的儿童性剥削内容（CSAM）', '——此类内容将被立即举报至相关执法机构'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '本平台对以下内容采取零容忍政策，一经发现将立即删除内容并封禁账号：',
          style: normalStyle,
        ),
        const SizedBox(height: 8),
        ...List.generate(items.length, (i) {
          final (keyword, suffix) = items[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${i + 1}. ',
                    style: normalStyle,
                  ),
                  TextSpan(
                    text: keyword,
                    style: highlightStyle,
                  ),
                  if (suffix.isNotEmpty)
                    TextSpan(
                      text: suffix,
                      style: normalStyle,
                    ),
                  TextSpan(
                    text: '。',
                    style: normalStyle,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
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
