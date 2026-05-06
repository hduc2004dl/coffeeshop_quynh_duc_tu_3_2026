import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color _darkGreen = Color(0xFF274B33);
  static const Color _mediumGreen = Color(0xFF5A8D55);
  static const Color _lightGreen = Color(0xFFF2F5EE);
  static const Color _cream = Color(0xFFFAF7F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavbar(context),
            _buildHeroSection(context),
            _buildStorySection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Row(
        children: [
          const Text(
            'DQT Coffee',
            style: TextStyle(
              color: _darkGreen,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          _buildNavItem('Home'),
          _buildNavItem('Content'),
          _buildNavItem('About', active: true),
          const SizedBox(width: 28),
          _buildNavButton('Login'),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, {bool active = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          color: active ? _darkGreen : Colors.black87,
          fontSize: 16,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNavButton(String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4E7C45),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: _lightGreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'A coffee story brewed in every cup.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _darkGreen,
                    fontSize: size.width > 900 ? 52 : 38,
                    height: 1.08,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Kết nối hương vị, tâm hồn và khoảnh khắc thư giãn với cà phê tuyển chọn, phục vụ trong không gian xanh tươi mát.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xD72F5D3A),
                    fontSize: 18,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _mediumGreen,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Khám phá menu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
            Wrap(
              runSpacing: 24,
              spacing: 24,
              alignment: WrapAlignment.center,
              children: [
                _buildImageCard(
                  'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=80',
                  'Tinh túy cà phê rang xay',
                ),
                _buildImageCard(
                  'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=900&q=80',
                  'Thưởng thức mỗi khoảnh khắc',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, String caption) {
    return SizedBox(
      width: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            caption,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: _cream,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
      child: Flex(
        direction: size.width > 900 ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'OUR BEANS',
                      style: TextStyle(
                        letterSpacing: 1.6,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'We believe in coffee made with care.',
                      style: TextStyle(fontSize: 15, color: Colors.black45),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Chúng tôi là những người yêu cà phê, chuyên gia chọn lựa hạt, và người kể chuyện cho mỗi tách coffee được phục vụ với tâm huyết.',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Thực đơn của chúng tôi hội tụ espresso đậm đà, latte bơ mềm mịn, cappuccino thơm ngất, và thức uống đặc biệt từ các loại hạt tuyển chọn. Không gian ấm cúng, ánh sáng tự nhiên và sắc xanh hoà cùng mùi cà phê sẽ luôn chào đón bạn.',
                  style: TextStyle(fontSize: 16, height: 1.75),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hãy đến cùng bạn bè, làm việc thư giãn, hoặc đơn giản là dành cho mình một phút bình yên giữa nhịp sống hối hả.',
                  style: TextStyle(fontSize: 16, height: 1.75),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40, height: 32),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(
                'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=1000&q=80',
                fit: BoxFit.cover,
                height: size.width > 900 ? 520 : 340,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
