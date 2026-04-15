import 'package:flutter/material.dart';

void main() {
  runApp(const StarbucksApp());
}

// ─── 1. Dữ liệu Starbucks ────────────────────────────────────
final List<String> drinkNames = [
  'Caramel Frappuccino',
  'Green Tea Cream Frappuccino',
  'Caramel Macchiato',
  'Java Chip Frappuccino',
  'Cold Brew',
  'Iced Matcha Latte',
];

List<int> drinkPrices = [79000, 79000, 85000, 85000, 75000, 80000];

final Map<String, Map<String, dynamic>> drinkDetails = {
  'Caramel Frappuccino': {
    'emoji': '🧋',
    'category': 'Frappuccino',
    'caffeine': 'Trung bình',
    'bestSeller': true,
    'description': 'Caramel + Espresso + Kem tươi',
    'color': Color(0xFF8B6914),
  },
  'Green Tea Cream Frappuccino': {
    'emoji': '🍵',
    'category': 'Frappuccino',
    'caffeine': 'Thấp',
    'bestSeller': true,
    'description': 'Matcha Nhật Bản + Sữa + Kem',
    'color': Color(0xFF4CAF50),
  },
  'Caramel Macchiato': {
    'emoji': '☕',
    'category': 'Espresso',
    'caffeine': 'Cao',
    'bestSeller': false,
    'description': 'Espresso + Sữa + Sốt Caramel',
    'color': Color(0xFFBF8040),
  },
  'Java Chip Frappuccino': {
    'emoji': '🍫',
    'category': 'Frappuccino',
    'caffeine': 'Trung bình',
    'bestSeller': false,
    'description': 'Chocolate chip + Đá xay + Kem',
    'color': Color(0xFF5D4037),
  },
  'Cold Brew': {
    'emoji': '🫗',
    'category': 'Cold Coffee',
    'caffeine': 'Cao',
    'bestSeller': false,
    'description': 'Ủ lạnh 20h – mượt mà, ít chua',
    'color': Color(0xFF263238),
  },
  'Iced Matcha Latte': {
    'emoji': '🌿',
    'category': 'Teavana',
    'caffeine': 'Thấp',
    'bestSeller': false,
    'description': 'Matcha + Sữa tươi + Đá',
    'color': Color(0xFF388E3C),
  },
};

// ─── App ──────────────────────────────────────────────────
class StarbucksApp extends StatelessWidget {
  const StarbucksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00704A)),
        useMaterial3: true,
      ),
      home: const StarbucksMenuScreen(),
    );
  }
}

class StarbucksMenuScreen extends StatelessWidget {
  const StarbucksMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int minPrice = drinkPrices.reduce((a, b) => a < b ? a : b);
    final int maxPrice = drinkPrices.reduce((a, b) => a > b ? a : b);
    final int bestSellerCount = drinkDetails.values.where((d) => d['bestSeller'] == true).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00704A),
        title: const Text('★ Starbucks Vietnam', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Summary Row ──
            Row(
              children: [
                _SummaryCard(label: 'Tổng món', value: '${drinkNames.length}', icon: Icons.coffee, color: const Color(0xFF00704A)),
                const SizedBox(width: 8),
                _SummaryCard(label: 'Best Seller', value: '$bestSellerCount', icon: Icons.star, color: const Color(0xFFD4A017)),
                const SizedBox(width: 8),
                _SummaryCard(label: 'Từ', value: '${minPrice ~/ 1000}K', icon: Icons.attach_money, color: const Color(0xFF1976D2)),
                const SizedBox(width: 8),
                _SummaryCard(label: 'Đến', value: '${maxPrice ~/ 1000}K', icon: Icons.show_chart, color: const Color(0xFFE64A19)),
              ],
            ),
            const SizedBox(height: 16),

            // ── 2. Google Map Section ──
            const _GoogleMapSection(),
            const SizedBox(height: 16),

            // ── 3. Menu Header ──
            const Text('Menu đồ uống', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
            Text('Giá Tall size • Cập nhật 2026', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(height: 12),

            // ── 4. List View ──
            Expanded(
              child: ListView.separated(
                itemCount: drinkNames.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final String name = drinkNames[index];
                  final Map<String, dynamic> detail = drinkDetails[name]!;
                  return DrinkRowItem(
                    name: name,
                    price: drinkPrices[index],
                    emoji: detail['emoji'],
                    category: detail['category'],
                    caffeine: detail['caffeine'],
                    description: detail['description'],
                    isBestSeller: detail['bestSeller'],
                    accentColor: detail['color'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Google Map Widget ──────────────────────────────────────────
class _GoogleMapSection extends StatelessWidget {
  const _GoogleMapSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        image: const DecorationImage(
          image: NetworkImage('https://www.google.com/maps/d/thumbnail?mid=1_K0S9LwH1K-M6N0Z6UfTjY8hV_M'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Center(child: Icon(Icons.location_on, color: Color(0xFFEA4335), size: 36)),
          Positioned(
            bottom: 8, left: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Icon(Icons.near_me, size: 14, color: Color(0xFF1A73E8)),
                  SizedBox(width: 4),
                  Text('Starbucks Reserve - 0.5km', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Các Widget bổ trợ (Giữ nguyên giao diện cũ của bạn) ───────────────
class _SummaryCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class DrinkRowItem extends StatelessWidget {
  final String name, emoji, category, caffeine, description;
  final int price;
  final bool isBestSeller;
  final Color accentColor;

  const DrinkRowItem({super.key, required this.name, required this.price, required this.emoji, required this.category, required this.caffeine, required this.description, required this.isBestSeller, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(color: accentColor.withOpacity(0.1), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis)),
                    if (isBestSeller) ...[
                      const SizedBox(width: 4),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFFFF3CD), borderRadius: BorderRadius.circular(4)), child: const Text('★ Best', style: TextStyle(fontSize: 9, color: Color(0xFFB8860B), fontWeight: FontWeight.bold))),
                    ]
                  ],
                ),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _Tag(label: category, color: accentColor),
                    const SizedBox(width: 6),
                    _Tag(label: 'Caffeine: $caffeine', color: caffeine == 'Cao' ? Colors.red : Colors.green),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${price ~/ 1000}K', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown[700])),
              const Text('Tall', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withOpacity(0.2))),
      child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}