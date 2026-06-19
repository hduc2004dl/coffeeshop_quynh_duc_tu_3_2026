import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const StarbucksApp());
}

// ─── DATA MODELS ──────────────────────────────────────────
class Drink {
  final String id, name, emoji, category, caffeine, description;
  final int price;
  final bool isBestSeller;
  bool isAvailable;

  Drink({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    required this.caffeine,
    required this.description,
    required this.price,
    this.isBestSeller = false,
    this.isAvailable = true,
  });

  String get formattedPrice => '${price ~/ 1000}K';
  static const String storeName = 'Starbucks Vietnam';
  static const int maxOrderQuantity = 20;
}

// ─── STATIC DRINK DATA ────────────────────────────────────
class DrinkData {
  static final List<Drink> drinks = [
    Drink(id:'D001', name:'Caramel Frappuccino',         emoji:'🧋', category:'Frappuccino',  caffeine:'Trung bình', description:'Caramel + Espresso + Kem tươi',   price:79000, isBestSeller:true),
    Drink(id:'D002', name:'Green Tea Frappuccino',        emoji:'🍵', category:'Frappuccino',  caffeine:'Thấp',       description:'Matcha Nhật Bản + Sữa + Kem',     price:79000, isBestSeller:true),
    Drink(id:'D003', name:'Caramel Macchiato',            emoji:'☕', category:'Espresso',     caffeine:'Cao',        description:'Espresso + Sữa + Sốt Caramel',    price:85000),
    Drink(id:'D004', name:'Java Chip Frappuccino',        emoji:'🍫', category:'Frappuccino',  caffeine:'Trung bình', description:'Chocolate chip + Đá xay + Kem',   price:85000),
    Drink(id:'D005', name:'Cold Brew',                    emoji:'🫗', category:'Cold Coffee',  caffeine:'Cao',        description:'Ủ lạnh 20h – mượt mà, ít chua',  price:75000),
    Drink(id:'D006', name:'Iced Matcha Latte',            emoji:'🌿', category:'Teavana',      caffeine:'Thấp',       description:'Matcha + Sữa tươi + Đá',          price:80000),
  ];

  static List<String> get categories =>
      ['Tất cả', ...drinks.map((d) => d.category).toSet().toList()];
}

const kGreen     = Color(0xFF00704A);
const kGreenDark = Color(0xFF004F35);
const kGold      = Color(0xFFCBA258);
const kBg        = Color(0xFFF1F8F5);
const kCard      = Color(0xFFFFFFFF);

class StarbucksApp extends StatelessWidget {
  const StarbucksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starbucks Vietnam',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        fontFamily: 'Roboto',
      ),
      home: const MainShell(),
    );
  }
}

// ─── MAIN SHELL với Liquid Glass NavBar ───────────────────
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  final List<Widget> _screens = const [
    HomeScreen(),
    ContentScreen(),
    AboutScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    _fadeCtrl.reverse().then((_) {
      setState(() => _currentIndex = index);
      _fadeCtrl.forward();
    });
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      extendBody: true, // body goes behind NavBar → liquid glass effect
      body: FadeTransition(
        opacity: _fadeAnim,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: _LiquidGlassNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

// ─── LIQUID GLASS NAVIGATION BAR ──────────────────────────
class _LiquidGlassNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _LiquidGlassNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: Icons.home_rounded,         activeIcon: Icons.home_rounded,     label: 'Home'),
    _NavItem(icon: Icons.grid_view_rounded,     activeIcon: Icons.grid_view_rounded, label: 'Content'),
    _NavItem(icon: Icons.person_rounded,        activeIcon: Icons.person_rounded,   label: 'About'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: bottom + 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          // Liquid Glass = Blur + frosted tint
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.28),
                  Colors.white.withOpacity(0.10),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_items.length, (i) {
                return _NavTab(
                  item: _items[i],
                  isActive: currentIndex == i,
                  onTap: () => onTap(i),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon, activeIcon;
  final String label;
  const _NavItem({required this.icon, required this.activeIcon, required this.label});
}

class _NavTab extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavTab({required this.item, required this.isActive, required this.onTap});

  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _pill;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _scale = Tween(begin: 1.0, end: 1.12).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _pill  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    if (widget.isActive) _ctrl.forward();
  }

  @override
  void didUpdateWidget(_NavTab old) {
    super.didUpdateWidget(old);
    if (widget.isActive != old.isActive) {
      widget.isActive ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return SizedBox(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pill indicator + icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glass pill behind active icon
                    SizeTransition(
                      sizeFactor: _pill,
                      axis: Axis.horizontal,
                      axisAlignment: 0,
                      child: Container(
                        width: 52,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: kGreen.withOpacity(0.20),
                          border: Border.all(color: kGreen.withOpacity(0.35), width: 0.8),
                        ),
                      ),
                    ),
                    ScaleTransition(
                      scale: _scale,
                      child: Icon(
                        widget.isActive ? widget.item.activeIcon : widget.item.icon,
                        size: 22,
                        color: widget.isActive ? kGreen : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w400,
                    color: widget.isActive ? kGreen : Colors.grey.shade600,
                  ),
                  child: Text(widget.item.label),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SCREEN 1: HOME
// ════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Tất cả';

  List<Drink> get _filtered {
    if (_selectedCategory == 'Tất cả') return DrinkData.drinks;
    return DrinkData.drinks.where((d) => d.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: kGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kGreen, kGreenDark],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('★', style: TextStyle(color: kGold, fontSize: 18)),
                            const SizedBox(width: 8),
                            const Text('Starbucks Vietnam',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.white, size: 14),
                                  SizedBox(width: 4),
                                  Text('Hà Nội', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('Xin chào! Bạn muốn gọi gì hôm nay? ☕',
                            style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner ưu đãi
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B5E3A), Color(0xFF00704A)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: kGreen.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: kGold.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('ƯU ĐÃI HÔM NAY',
                                    style: TextStyle(color: kGold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                              ),
                              const SizedBox(height: 8),
                              const Text('Giảm 20%\nFrappuccino',
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.2)),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: kGreen,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  elevation: 0,
                                ),
                                child: const Text('Xem ngay', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        const Text('🧋', style: TextStyle(fontSize: 64)),
                      ],
                    ),
                  ),
                ),

                // Filter chips
                const SizedBox(height: 16),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: DrinkData.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final cat = DrinkData.categories[i];
                      final active = cat == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: active ? kGreen : kCard,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: active ? kGreen : Colors.grey.shade300),
                          ),
                          child: Text(cat,
                              style: TextStyle(
                                  color: active ? Colors.white : Colors.grey.shade700,
                                  fontSize: 12,
                                  fontWeight: active ? FontWeight.bold : FontWeight.normal)),
                        ),
                      );
                    },
                  ),
                ),

                // Menu title
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  child: Row(
                    children: [
                      const Text('Menu đồ uống',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
                      const Spacer(),
                      Text('${_filtered.length} món',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drink list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _DrinkCard(drink: _filtered[i]),
                ),
                childCount: _filtered.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrinkCard extends StatelessWidget {
  final Drink drink;
  const _DrinkCard({required this.drink});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: kGreen, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: kGreen.withOpacity(0.08), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(drink.emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(drink.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          overflow: TextOverflow.ellipsis),
                    ),
                    if (drink.isBestSeller) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFFFF3CD), borderRadius: BorderRadius.circular(6)),
                        child: const Text('★ Best', style: TextStyle(fontSize: 9, color: Color(0xFFB8860B), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(drink.description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _Chip(drink.category, kGreen),
                    const SizedBox(width: 6),
                    _Chip('Caffeine: ${drink.caffeine}',
                        drink.caffeine == 'Cao' ? Colors.red.shade400 : Colors.green.shade600),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(drink.formattedPrice,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown.shade700)),
              const Text('Tall', style: TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: kGreen, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SCREEN 2: CONTENT
// ════════════════════════════════════════════════════════════
class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final drinks = DrinkData.drinks;
    final minPrice = drinks.map((d) => d.price).reduce((a, b) => a < b ? a : b);
    final maxPrice = drinks.map((d) => d.price).reduce((a, b) => a > b ? a : b);
    final bestSellers = drinks.where((d) => d.isBestSeller).toList();
    final categories = drinks.map((d) => d.category).toSet();

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kGreen,
        title: const Text('Nội dung & Chức năng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.white.withOpacity(0.15)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        children: [
          // STAT CARDS
          const _SectionTitle('Tổng quan menu'),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.8,
            children: [
              _StatCard(icon: Icons.coffee, label: 'Tổng đồ uống', value: '${drinks.length}', color: kGreen),
              _StatCard(icon: Icons.star_rounded, label: 'Best Seller', value: '${bestSellers.length}', color: kGold),
              _StatCard(icon: Icons.trending_down_rounded, label: 'Giá thấp nhất', value: '${minPrice ~/ 1000}K', color: Colors.blue.shade600),
              _StatCard(icon: Icons.trending_up_rounded, label: 'Giá cao nhất', value: '${maxPrice ~/ 1000}K', color: Colors.orange.shade700),
            ],
          ),

          const SizedBox(height: 24),
          const _SectionTitle('Danh mục đồ uống'),
          const SizedBox(height: 10),
          ...categories.map((cat) {
            final count = drinks.where((d) => d.category == cat).length;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(color: kGreen, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 12),
                  Text(cat, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: kGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('$count món', style: const TextStyle(color: kGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 24),
          const _SectionTitle('Mô hình dữ liệu'),
          const SizedBox(height: 10),
          _InfoCard(
            icon: Icons.code_rounded,
            title: 'Drink.dart',
            subtitle: '9 biến · 6 phương thức · 2 static methods',
            tags: ['id', 'name', 'price', 'emoji', 'category', 'isBestSeller'],
          ),
          const SizedBox(height: 8),
          _InfoCard(
            icon: Icons.list_alt_rounded,
            title: 'ListDrink.dart',
            subtitle: 'CRUD đầy đủ: Create / Read / Edit / Delete',
            tags: ['create()', 'readAll()', 'edit()', 'delete()', 'findById()'],
          ),
          const SizedBox(height: 8),
          _InfoCard(
            icon: Icons.shopping_cart_rounded,
            title: 'Cart.dart + CartItem.dart',
            subtitle: 'Quản lý giỏ hàng, tính tổng tiền',
            tags: ['addItem()', 'removeItem()', 'totalAmount'],
          ),

          const SizedBox(height: 24),
          const _SectionTitle('Kiến thức áp dụng'),
          const SizedBox(height: 10),
          _TechRow(icon: '⚡', title: 'static', desc: 'DrinkData, maxOrderQuantity dùng chung toàn app'),
          _TechRow(icon: '🔷', title: 'Generics', desc: 'Container<T> bọc dữ liệu đồ uống'),
          _TechRow(icon: '🏗️', title: 'OOP', desc: 'Drink, ListDrink, Cart, Order, User'),
          _TechRow(icon: '📱', title: 'Flutter', desc: 'Material 3, Navigator, Liquid Glass NavBar'),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B4332)));
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final List<String> tags;
  const _InfoCard({required this.icon, required this.title, required this.subtitle, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kGreen, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6, runSpacing: 4,
            children: tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: kGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(t, style: const TextStyle(fontSize: 10, color: kGreen, fontWeight: FontWeight.w600)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _TechRow extends StatelessWidget {
  final String icon, title, desc;
  const _TechRow({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SCREEN 3: ABOUT
// ════════════════════════════════════════════════════════════
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _members = [
    {'name': 'Nguyễn Văn A', 'mssv': 'SV123456', 'role': 'Leader', 'task': 'UI/UX + AppBar'},
    {'name': 'Trần Thị B',   'mssv': 'SV234567', 'role': 'Developer', 'task': 'Drink.dart + CRUD'},
    {'name': 'Lê Văn C',     'mssv': 'SV345678', 'role': 'Developer', 'task': 'Cart + Order'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: kGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kGreenDark, kGreen],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                        ),
                        child: const Center(child: Text('☕', style: TextStyle(fontSize: 30))),
                      ),
                      const SizedBox(height: 8),
                      const Text('Starbucks Vietnam App',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Phiên bản 1.0.0 · Lập trình Mobile 2026',
                          style: TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // Thông tin app
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _AboutRow('Môn học', 'Lập trình Mobile'),
                      _AboutRow('Framework', 'Flutter 3.x + Dart'),
                      _AboutRow('Thiết kế', 'Material 3 + Liquid Glass'),
                      _AboutRow('GitHub', 'github.com/nhóm/starbucks'),
                      _AboutRow('Cập nhật', '05/2026'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const _SectionTitle('Thành viên nhóm'),
                const SizedBox(height: 10),

                ..._members.asMap().entries.map((e) {
                  final idx = e.key;
                  final m = e.value;
                  final colors = [kGreen, kGold, const Color(0xFF5C4A1E)];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kCard,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48, height: 48,
                          decoration: BoxDecoration(color: colors[idx], shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(m['name']![0],
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: colors[idx].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(m['role']!,
                                        style: TextStyle(fontSize: 10, color: colors[idx], fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text('MSSV: ${m['mssv']}',
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                              Text('Nhiệm vụ: ${m['task']}',
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),
                const _SectionTitle('Tech Stack'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: [
                    'Flutter 3.x', 'Dart 3.x', 'Material 3',
                    'Liquid Glass', 'OOP', 'static', 'Generics',
                    'CRUD', 'Navigator', 'GitHub',
                  ].map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: kGreen.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kGreen.withOpacity(0.2)),
                    ),
                    child: Text(t, style: const TextStyle(fontSize: 12, color: kGreen, fontWeight: FontWeight.w600)),
                  )).toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final String key1, value;
  const _AboutRow(this.key1, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Text(key1, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
