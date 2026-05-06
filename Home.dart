import 'package:flutter/material.dart';

void main() {
  runApp(const DQTApp());
}

class DQTApp extends StatelessWidget {
  const DQTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DQT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A4A3A),
          brightness: Brightness.dark,
        ),
      ),
      home: const DQTPage(),
    );
  }
}

// ─── COLORS ──────────────────────────────────────────────
const kDarkGreen = Color(0xFF0F2D22);
const kMedGreen = Color(0xFF1A4A3A);
const kBtnGreen = Color(0xFF3D8B6E);
const kAccentGreen = Color(0xFF4CAF87);
const kTextLight = Color(0xFFE8E8E0);
const kTextMuted = Color(0xFFB0C4B8);
const kCardBg = Color(0xFF163828);
const kInputBg = Color(0xFFF0F4F1);

// ─── MAIN PAGE ────────────────────────────────────────────
class DQTPage extends StatelessWidget {
  const DQTPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreen,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _NavBar(),
            _HeroSection(),
            _FooterSection(),
          ],
        ),
      ),
    );
  }
}

// ─── NAV BAR ─────────────────────────────────────────────
class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    final navItems = ['Sản Phẩm', 'Solutions', 'Cộng Đồng', 'Tài liệu', 'Sản phẩm', 'Liên hệ'];

    return Container(
      color: kDarkGreen,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: kBtnGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.coffee, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'DQT',
                style: TextStyle(
                  color: kTextLight,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          // Nav links
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: navItems.map<Widget>((item) => _NavLink(label: item)).toList(),
            ),
          ),
          // Buttons
          Row(
            children: [
              _OutlineButton(label: 'Đăng nhập'),
              const SizedBox(width: 10),
              _FilledButton(label: 'Đăng ký'),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  const _NavLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        label,
        style: const TextStyle(color: kTextLight, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  const _OutlineButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: kTextLight,
        side: const BorderSide(color: kTextLight, width: 1.2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String label;
  const _FilledButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: kBtnGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}

// ─── HERO SECTION ────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 540),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2D22), Color(0xFF1A4A3A), Color(0xFF0F3828)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative leaf circles (background blobs)
          Positioned(
            left: -60,
            bottom: 40,
            child: _DecorativeCircle(size: 220, color: kMedGreen.withOpacity(0.4)),
          ),
          Positioned(
            right: -40,
            top: 20,
            child: _DecorativeCircle(size: 160, color: kMedGreen.withOpacity(0.25)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left text
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'DQT',
                        style: TextStyle(
                          color: kTextLight,
                          fontSize: 54,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Chia sẻ phản hồi của bạn',
                        style: TextStyle(
                          color: kAccentGreen,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 40,
                        height: 3,
                        decoration: BoxDecoration(
                          color: kBtnGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Đôi khi, việc nghỉ ngơi và không làm gì cả chính là cách nhanh nhất để bạn tìm lại phương hướng",
                        style: TextStyle(
                          color: kTextMuted,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                // Right form card
                const Expanded(
                  flex: 4,
                  child: _ContactCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final double size;
  final Color color;
  const _DecorativeCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ─── CONTACT CARD ─────────────────────────────────────────
class _ContactCard extends StatefulWidget {
  const _ContactCard();

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  final _nameCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FormField(label: 'Name', hint: 'Tên của bạn', controller: _nameCtrl),
          const SizedBox(height: 16),
          _FormField(label: 'Biệt danh', hint: 'Nickname', controller: _userCtrl),
          const SizedBox(height: 16),
          _FormField(label: 'Email', hint: 'Your email', controller: _emailCtrl),
          const SizedBox(height: 16),
          _FormField(
            label: 'Thư gửi',
            hint: 'nhập vào...',
            controller: _msgCtrl,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kBtnGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text(
                'Gửi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const _FormField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kTextLight,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Color(0xFF1A3A2A), fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            filled: true,
            fillColor: kInputBg,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kBtnGreen, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── FOOTER ───────────────────────────────────────────────
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0A2018),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand column
          SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: kBtnGreen,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(Icons.coffee, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'DQT',
                      style: TextStyle(
                        color: kTextLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cộng đồng dành cho những người yêu và sáng tạo cà phê. Cùng chia sẻ, học hỏi và phát triển',
                  style: TextStyle(color: kTextMuted, fontSize: 13, height: 1.6),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _SocialIcon(Icons.facebook),
                    _SocialIcon(Icons.flutter_dash), // Twitter placeholder
                    _SocialIcon(Icons.camera_alt_outlined),
                    _SocialIcon(Icons.link),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 160,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            color: kMedGreen.withOpacity(0.5),
          ),
          // Use cases
          Expanded(
            child: _FooterColumn(
              title: 'Use cases',
              links: ['UI design', 'UX design', 'Wireframing', 'Brainstorming', 'Online whiteboard', 'Team collaboration'],
            ),
          ),
          // Explore
          Expanded(
            child: _FooterColumn(
              title: 'Khám phá',
              links: ['Design', 'Prototyping', 'Development features', 'Design systems', 'Collaboration features', 'Sản phẩm'],
            ),
          ),
          // Resources
          Expanded(
            child: _FooterColumn(
              title: 'Tài nguyên',
              links: ['Blog', 'Kinh nghiệm', 'Hướng dẫn', 'Dự án', 'Hỗ trợ', 'Thư viện'],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kMedGreen,
      ),
      child: Icon(icon, color: kTextLight, size: 16),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kTextLight,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map<Widget>(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              link,
              style: const TextStyle(color: kTextMuted, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
