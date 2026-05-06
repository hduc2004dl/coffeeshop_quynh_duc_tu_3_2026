import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const StarbucksApp());
}

// ─── THEME CONSTANTS ──────────────────────────────────────
const kGreen     = Color(0xFF00704A);
const kGreenDark = Color(0xFF004F35);
const kGreenLight= Color(0xFFE8F5EE);
const kGold      = Color(0xFFC8993A);
const kBg        = Color(0xFFF7F6F1);
const kCard      = Color(0xFFFFFFFF);
const kBorder    = Color(0xFFE2E2DC);
const kMuted     = Color(0xFF777777);
const kText      = Color(0xFF1A1A1A);

// ─── MODELS ───────────────────────────────────────────────
class CartItem {
  final String id;
  final String name;
  final String emoji;
  final String category;
  final int unitPrice;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    required this.unitPrice,
    this.quantity = 1,
  });

  int get totalPrice => unitPrice * quantity;
  String get formattedUnit => '${_fmt(unitPrice)} / ly';
  String get formattedTotal => _fmt(totalPrice);

  static String _fmt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return '${buf.toString()} ₫';
  }
}

// ─── APP ──────────────────────────────────────────────────
class StarbucksApp extends StatelessWidget {
  const StarbucksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starbucks Cart',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: kBg,
      ),
      home: const CartScreen(),
    );
  }
}

// ════════════════════════════════════════════════════════════
// CART SCREEN — Layout giống World Peas Basket
// ════════════════════════════════════════════════════════════
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Dữ liệu giỏ hàng
  final List<CartItem> _items = [
    CartItem(id:'C001', name:'Caramel Frappuccino',        emoji:'🧋', category:'Frappuccino',  unitPrice:79000, quantity:1),
    CartItem(id:'C002', name:'Green Tea Frappuccino',       emoji:'🍵', category:'Frappuccino',  unitPrice:79000, quantity:2),
    CartItem(id:'C003', name:'Caramel Macchiato',           emoji:'☕', category:'Espresso',     unitPrice:85000, quantity:1),
  ];

  static const int _shippingFee = 25000;

  int get _subtotal    => _items.fold(0, (s, i) => s + i.totalPrice);
  int get _total       => _subtotal + _shippingFee;
  int get _totalItems  => _items.fold(0, (s, i) => s + i.quantity);

  // ── REMOVE ITEM ─────────────────────────────────────────
  void _removeItem(String id) {
    setState(() => _items.removeWhere((i) => i.id == id));
  }

  // ── EDIT QUANTITY BOTTOM SHEET ───────────────────────────
  void _openQtySheet(CartItem item) {
    int tempQty = item.quantity;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setS) => Container(
          decoration: const BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: kBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Item info
              Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: kGreenLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(item.emoji, style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(item.formattedUnit,
                          style: const TextStyle(color: kGreen, fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Stepper
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StepBtn(
                    icon: Icons.remove,
                    onTap: () { if (tempQty > 1) setS(() => tempQty--); },
                  ),
                  const SizedBox(width: 24),
                  Column(
                    children: [
                      Text('$tempQty',
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold,
                              fontFeatures: [FontFeature.tabularFigures()])),
                      const Text('ly', style: TextStyle(color: kMuted, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 24),
                  _StepBtn(
                    icon: Icons.add,
                    onTap: () { if (tempQty < 20) setS(() => tempQty++); },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Preview total
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: kGreenLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Thành tiền: ${CartItem._fmt(tempQty * item.unitPrice)}',
                  style: const TextStyle(color: kGreen, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kBorder),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Huỷ', style: TextStyle(color: kMuted)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => item.quantity = tempQty);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text('Lưu', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CHECKOUT ────────────────────────────────────────────
  void _checkout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🎉 Đặt hàng thành công!'),
        content: Text(
          'Tổng cộng: ${CartItem._fmt(_total)}\n'
              '${_totalItems} ly đang được pha chế ☕\n'
              'Thời gian: 30–45 phút',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: kGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          // ── TOP NAV ─────────────────────────────────────
          _TopNav(itemCount: _totalItems),

          // ── PAGE CONTENT ────────────────────────────────
          Expanded(
            child: _items.isEmpty
                ? _EmptyCart()
                : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final isWide = MediaQuery.of(context).size.width > 720;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 16,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── PAGE HEADER ─────────────────────────────────
          _PageHeader(itemCount: _items.length),
          const SizedBox(height: 28),

          // ── MAIN LAYOUT: left + right ────────────────────
          isWide
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: item list
              Expanded(child: _buildItemList()),
              const SizedBox(width: 32),
              // Right: order summary
              SizedBox(width: 340, child: _buildOrderSummary()),
            ],
          )
              : Column(
            children: [
              _buildItemList(),
              const SizedBox(height: 24),
              _buildOrderSummary(),
            ],
          ),
        ],
      ),
    );
  }

  // ── ITEM LIST (LEFT) ────────────────────────────────────
  Widget _buildItemList() {
    return Column(
      children: [
        ...List.generate(_items.length, (i) {
          final item = _items[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _CartItemCard(
              item: item,
              onEdit: () => _openQtySheet(item),
              onRemove: () => _removeItem(item.id),
            ),
          );
        }),

        // Pagination indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PagBtn(icon: Icons.chevron_left),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: kText,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '1–${_items.length} / ${_items.length}',
                style: const TextStyle(
                    color: Colors.white, fontSize: 12,
                    fontFeatures: [FontFeature.tabularFigures()]),
              ),
            ),
            const SizedBox(width: 12),
            _PagBtn(icon: Icons.chevron_right),
          ],
        ),
      ],
    );
  }

  // ── ORDER SUMMARY (RIGHT) ───────────────────────────────
  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tổng hoá đơn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Row: Tạm tính
          _SummaryRow(label: 'Tạm tính',    value: CartItem._fmt(_subtotal)),
          const _Divider(),
          _SummaryRow(label: 'Phí giao hàng', value: CartItem._fmt(_shippingFee)),
          const _Divider(),
          _SummaryRow(label: 'Khuyến mãi',  value: '– 0 ₫', valueColor: kGreen),
          const SizedBox(height: 4),

          // Total
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: kText, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng cộng',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(CartItem._fmt(_total),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFeatures: [FontFeature.tabularFigures()])),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Text(
            'Giá đã bao gồm VAT.\nThời gian giao hàng 30–45 phút.',
            style: TextStyle(color: kMuted, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 20),

          // Pay button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Tiếp tục thanh toán',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),
          // Promo code
          _PromoCodeRow(),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// CART ITEM CARD — layout giống World Peas (ảnh trái, info phải)
// ════════════════════════════════════════════════════════════
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          // ── IMAGE SECTION (trái) ─────────────────────────
          Container(
            width: 130,
            height: 115,
            decoration: BoxDecoration(
              color: kGreenLight,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              border: const Border(right: BorderSide(color: kBorder)),
            ),
            alignment: Alignment.center,
            child: Text(item.emoji, style: const TextStyle(fontSize: 52)),
          ),

          // ── BODY (giữa) ──────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên + giá
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ),
                      const SizedBox(width: 12),
                      Text(item.formattedTotal,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFeatures: [FontFeature.tabularFigures()])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(item.formattedUnit,
                      style: const TextStyle(color: kGreen, fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),

                  // Số lượng + nút sửa
                  Row(
                    children: [
                      // Qty pill — bấm để mở bottom sheet
                      GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: kBorder, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Text('${item.quantity} ly',
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit_outlined, size: 15, color: kMuted),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Nút xoá
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.close_rounded),
                        color: kMuted,
                        iconSize: 20,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SUPPORTING WIDGETS
// ════════════════════════════════════════════════════════════

class _TopNav extends StatelessWidget {
  final int itemCount;
  const _TopNav({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: kCard,
        border: Border(bottom: BorderSide(color: kBorder)),
      ),
      child: Row(
        children: [
          // Logo
          Text('★ Starbucks',
              style: TextStyle(
                  color: kGreen, fontWeight: FontWeight.bold,
                  fontSize: 20, letterSpacing: -0.5)),
          const Spacer(),
          // Nav links
          for (final link in ['Menu', 'Ưu đãi', 'Cửa hàng'])
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(link, style: const TextStyle(color: kMuted, fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          const SizedBox(width: 24),
          // Basket button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: kGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Giỏ hàng ($itemCount)',
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  final int itemCount;
  const _PageHeader({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text('Giỏ hàng',
                style: TextStyle(
                    fontSize: 48, fontWeight: FontWeight.bold,
                    letterSpacing: -2, height: 1)),
            const SizedBox(width: 16),
            Text('$itemCount món',
                style: const TextStyle(color: kMuted, fontSize: 16, fontWeight: FontWeight.w400)),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: kBorder, thickness: 1),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: kMuted, fontSize: 15)),
          Text(value, style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500,
              color: valueColor,
              fontFeatures: const [FontFeature.tabularFigures()])),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return const Divider(color: kBorder, thickness: 1, height: 1);
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kBorder, width: 1.5),
          color: Colors.white,
        ),
        child: Icon(icon, size: 20, color: kText),
      ),
    );
  }
}

class _PagBtn extends StatelessWidget {
  final IconData icon;
  const _PagBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kBorder, width: 1.5),
        color: Colors.white,
      ),
      child: Icon(icon, size: 18, color: kMuted),
    );
  }
}

class _PromoCodeRow extends StatefulWidget {
  const _PromoCodeRow();

  @override
  State<_PromoCodeRow> createState() => _PromoCodeRowState();
}

class _PromoCodeRowState extends State<_PromoCodeRow> {
  bool _open = false;
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
          child: const Text(
            'Bạn có mã giảm giá?',
            style: TextStyle(
                color: kGreen, fontSize: 13,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
        if (_open) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Nhập mã...',
                    hintStyle: const TextStyle(color: kMuted),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kGreen),
                    ),
                    filled: true, fillColor: kBg,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  final msg = _ctrl.text.trim().toUpperCase() == 'SBUX20'
                      ? '✅ Áp dụng thành công! Giảm 20%'
                      : '❌ Mã không hợp lệ';
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(msg)));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: kGreen,
                  side: const BorderSide(color: kGreen),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Áp dụng', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text('Giỏ hàng trống',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 8),
          const Text('Thêm đồ uống từ menu nhé!',
              style: TextStyle(color: kMuted, fontSize: 15)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: kGreen, foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Xem menu', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}