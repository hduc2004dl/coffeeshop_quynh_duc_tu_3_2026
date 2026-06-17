import 'dart:ui';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  runApp(const StarbucksApp());
}

extension FirstOrNullExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class AppStrings {
  static bool isVietnamese = true;

  static String get(String key) => isVietnamese
      ? _vi[key] ?? key
      : _en[key] ?? key;

  static const _vi = {
    'app_name': 'Starbucks Vietnam',
    'welcome_back': 'Chào mừng bạn trở lại!',
    'login': 'Đăng nhập',
    'register': 'Đăng ký',
    'email': 'Email',
    'password': 'Mật khẩu',
    'full_name': 'Họ và tên',
    'password_hint': 'Mật khẩu (tối thiểu 6 ký tự)',
    'forgot_password': 'Quên mật khẩu?',
    'create_account': 'Tạo tài khoản',
    'or_login_with': 'hoặc đăng nhập với',
    'terms': 'Bằng cách đăng ký, bạn đồng ý với Điều khoản dịch vụ',
    'home': 'Home',
    'content': 'Nội dung',
    'cart': 'Giỏ hàng',
    'about': 'About',
    'greeting': 'Xin chào',
    'what_drink': 'Bạn muốn gọi gì? ☕',
    'location': 'Hà Nội',
    'today_offer': 'ƯU ĐÃI HÔM NAY',
    'discount': 'Giảm 20%\nFrappuccino',
    'see_now': 'Xem ngay',
    'menu': 'Menu đồ uống',
    'all': 'Tất cả',
    'added_to_cart': 'Đã thêm',
    'to_cart': 'vào giỏ',
    'my_cart': 'Giỏ hàng của bạn',
    'delete_all': 'Xoá tất cả',
    'empty_cart': 'Giỏ hàng trống',
    'add_drinks': 'Thêm đồ uống yêu thích vào giỏ nhé!',
    'promo_code': 'Nhập mã giảm giá',
    'subtotal': 'Tạm tính',
    'delivery_fee': 'Phí giao hàng',
    'total': 'Tổng cộng',
    'order': 'Đặt hàng',
    'clear_cart': 'Xoá giỏ hàng?',
    'clear_confirm': 'Bạn có chắc muốn xoá tất cả sản phẩm?',
    'cancel': 'Huỷ',
    'delete': 'Xoá',
    'order_success': 'Đặt hàng thành công!',
    'order_brewing': 'Đơn hàng của bạn đang được pha chế.\nDự kiến: 10–15 phút',
    'great': 'Tuyệt vời!',
    'logout': 'Đăng xuất',
    'logout_confirm': 'Bạn có chắc muốn đăng xuất khỏi tài khoản?',
    'logout_q': 'Đăng xuất?',
    'guest': 'Khách',
    'settings': 'Cài đặt',
    'language': 'Ngôn ngữ',
    'language_vi': 'Tiếng Việt',
    'language_en': 'English',
    'notifications': 'Thông báo đẩy',
    'dark_mode': 'Chế độ tối',
    'sound': 'Âm thanh',
    'about_app': 'Về ứng dụng',
    'version': 'Phiên bản',
    'loyalty_points': 'Điểm thưởng',
    'my_qr': 'QR của tôi',
    'scan_earn': 'Quét để tích điểm',
    'points_balance': 'Số dư điểm',
    'stars': 'sao',
    'gold_member': 'Thành viên Vàng',
    'green_member': 'Thành viên Xanh',
    'next_reward': 'Còn thiếu để nhận thưởng tiếp theo',
    'qr_instruction': 'Xuất trình mã QR này tại quầy thu ngân\ntrước khi thanh toán để tích điểm',
    'history_points': 'Lịch sử điểm',
    'earned': 'Đã cộng',
    'overview': 'Tổng quan menu',
    'total_drinks': 'Tổng đồ uống',
    'lowest_price': 'Giá thấp nhất',
    'highest_price': 'Giá cao nhất',
    'categories': 'Danh mục đồ uống',
    'data_model': 'Mô hình dữ liệu',
    'knowledge': 'Kiến thức áp dụng',
    'content_title': 'Nội dung & Chức năng',
    'members': 'Thành viên nhóm',
    'tech_stack': 'Tech Stack',
    'subject': 'Môn học',
    'framework': 'Framework',
    'design': 'Thiết kế',
    'updated': 'Cập nhật',
    'task': 'Nhiệm vụ',
    'items': 'món',
    'best_seller': 'Best Seller',
    'refresh_qr': 'Làm mới QR',
    'close': 'Đóng',
  };

  static const _en = {
    'app_name': 'Starbucks Vietnam',
    'welcome_back': 'Welcome back!',
    'login': 'Sign in',
    'register': 'Sign up',
    'email': 'Email',
    'password': 'Password',
    'full_name': 'Full name',
    'password_hint': 'Password (min 6 characters)',
    'forgot_password': 'Forgot password?',
    'create_account': 'Create account',
    'or_login_with': 'or sign in with',
    'terms': 'By signing up, you agree to our Terms of Service',
    'home': 'Home',
    'content': 'Content',
    'cart': 'Cart',
    'about': 'About',
    'greeting': 'Hello',
    'what_drink': 'What would you like? ☕',
    'location': 'Hanoi',
    'today_offer': "TODAY'S OFFER",
    'discount': '20% Off\nFrappuccino',
    'see_now': 'View now',
    'menu': 'Drink menu',
    'all': 'All',
    'added_to_cart': 'Added',
    'to_cart': 'to cart',
    'my_cart': 'Your cart',
    'delete_all': 'Clear all',
    'empty_cart': 'Cart is empty',
    'add_drinks': 'Add your favourite drinks to the cart!',
    'promo_code': 'Enter promo code',
    'subtotal': 'Subtotal',
    'delivery_fee': 'Delivery fee',
    'total': 'Total',
    'order': 'Order',
    'clear_cart': 'Clear cart?',
    'clear_confirm': 'Are you sure you want to remove all items?',
    'cancel': 'Cancel',
    'delete': 'Delete',
    'order_success': 'Order placed!',
    'order_brewing': 'Your order is being prepared.\nEstimated: 10–15 minutes',
    'great': 'Great!',
    'logout': 'Sign out',
    'logout_confirm': 'Are you sure you want to sign out?',
    'logout_q': 'Sign out?',
    'guest': 'Guest',
    'settings': 'Settings',
    'language': 'Language',
    'language_vi': 'Tiếng Việt',
    'language_en': 'English',
    'notifications': 'Push notifications',
    'dark_mode': 'Dark mode',
    'sound': 'Sound',
    'about_app': 'About app',
    'version': 'Version',
    'loyalty_points': 'Loyalty points',
    'my_qr': 'My QR',
    'scan_earn': 'Scan to earn points',
    'points_balance': 'Points balance',
    'stars': 'stars',
    'gold_member': 'Gold Member',
    'green_member': 'Green Member',
    'next_reward': 'More needed for next reward',
    'qr_instruction': 'Show this QR code to the cashier\nbefore payment to earn points',
    'history_points': 'Points history',
    'earned': 'Earned',
    'overview': 'Menu overview',
    'total_drinks': 'Total drinks',
    'lowest_price': 'Lowest price',
    'highest_price': 'Highest price',
    'categories': 'Categories',
    'data_model': 'Data model',
    'knowledge': 'Applied knowledge',
    'content_title': 'Content & Functions',
    'members': 'Team members',
    'tech_stack': 'Tech Stack',
    'subject': 'Subject',
    'framework': 'Framework',
    'design': 'Design',
    'updated': 'Updated',
    'task': 'Task',
    'items': 'items',
    'best_seller': 'Best Seller',
    'refresh_qr': 'Refresh QR',
    'close': 'Close',
  };
}

String t(String key) => AppStrings.get(key);

// ════════════════════════════════════════════════════════════
// DATA MODELS
// ════════════════════════════════════════════════════════════
class Drink {
  final String id, name, emoji, category, caffeine, description;
  final int price;
  final bool isBestSeller, isAvailable;

  const Drink({
    required this.id, required this.name, required this.emoji,
    required this.category, required this.caffeine, required this.description,
    required this.price, this.isBestSeller = false, this.isAvailable = true,
  });

  String get formattedPrice => '${price ~/ 1000}K';

  static const String storeName = 'Starbucks Vietnam';
  static const int maxOrderQuantity = 20;
  static const int pointsPerOrder = 10; // points per 10K VND spent
}

class CartItem {
  final Drink drink;
  int quantity;
  String size, note;

  CartItem({required this.drink, this.quantity = 1, this.size = 'Tall', this.note = ''});

  int get subtotal => drink.price * quantity;
  String get formattedSubtotal => '${subtotal ~/ 1000}K';
}

class PointTransaction {
  final String description;
  final int points;
  final DateTime date;

  PointTransaction({required this.description, required this.points, required this.date});
}

// ════════════════════════════════════════════════════════════
// STATE MANAGEMENT
// ════════════════════════════════════════════════════════════
class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  int get cartCount => _cartItems.fold(0, (s, i) => s + i.quantity);
  int get cartTotal => _cartItems.fold(0, (s, i) => s + i.subtotal);
  String get formattedTotal => '${cartTotal ~/ 1000}K';

  // ── Loyalty Points ──────────────────────────────────────
  int _loyaltyPoints = 120;
  int get loyaltyPoints => _loyaltyPoints;
  String get memberTier => _loyaltyPoints >= 300 ? t('gold_member') : t('green_member');
  Color get tierColor => _loyaltyPoints >= 300 ? kGold : kGreen;
  int get pointsToNextReward => _loyaltyPoints >= 300 ? (500 - _loyaltyPoints) : (300 - _loyaltyPoints);

  final List<PointTransaction> _pointHistory = [
    PointTransaction(description: 'Caramel Frappuccino', points: 8, date: DateTime.now().subtract(const Duration(days: 1))),
    PointTransaction(description: 'Green Tea Frappuccino', points: 8, date: DateTime.now().subtract(const Duration(days: 3))),
    PointTransaction(description: 'Caramel Macchiato', points: 9, date: DateTime.now().subtract(const Duration(days: 5))),
    PointTransaction(description: 'Java Chip Frappuccino', points: 9, date: DateTime.now().subtract(const Duration(days: 8))),
    PointTransaction(description: 'Cold Brew', points: 8, date: DateTime.now().subtract(const Duration(days: 10))),
  ];
  List<PointTransaction> get pointHistory => List.unmodifiable(_pointHistory);

  // ── Settings ────────────────────────────────────────────
  bool _notificationsOn = true;
  bool _soundOn = true;
  bool get notificationsOn => _notificationsOn;
  bool get soundOn => _soundOn;

  void toggleNotifications() { _notificationsOn = !_notificationsOn; notifyListeners(); }
  void toggleSound() { _soundOn = !_soundOn; notifyListeners(); }

  void setLanguage(bool isVietnamese) {
    AppStrings.isVietnamese = isVietnamese;
    notifyListeners();
  }

  // ── QR Code ─────────────────────────────────────────────
  String _qrCode = '';
  String get qrCode => _qrCode;

  void generateQR() {
    final random = Random();
    final chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    _qrCode = List.generate(16, (_) => chars[random.nextInt(chars.length)]).join();
    notifyListeners();
  }

  void addLoyaltyPoints(int points, String description) {
    _loyaltyPoints += points;
    _pointHistory.insert(0, PointTransaction(
      description: description, points: points, date: DateTime.now(),
    ));
    notifyListeners();
  }

  // ── Auth ─────────────────────────────────────────────────
  void login(UserModel user) { _currentUser = user; notifyListeners(); }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
    await FacebookAuth.instance.logOut();
    _currentUser = null;
    _cartItems.clear();
    notifyListeners();
  }

  // ── Cart ─────────────────────────────────────────────────
  CartItem? _findCartItem(String id) {
    for (final item in _cartItems) { if (item.drink.id == id) return item; }
    return null;
  }

  void addToCart(Drink drink) {
    final existing = _findCartItem(drink.id);
    if (existing != null) {
      if (existing.quantity >= Drink.maxOrderQuantity) return;
      existing.quantity++;
    } else {
      _cartItems.add(CartItem(drink: drink));
    }
    notifyListeners();
  }

  void removeFromCart(String drinkId) {
    final before = _cartItems.length;
    _cartItems.removeWhere((i) => i.drink.id == drinkId);
    if (_cartItems.length != before) notifyListeners();
  }

  void increaseQty(String drinkId) {
    final item = _findCartItem(drinkId);
    if (item == null || item.quantity >= Drink.maxOrderQuantity) return;
    item.quantity++;
    notifyListeners();
  }

  void decreaseQty(String drinkId) {
    final item = _findCartItem(drinkId);
    if (item == null) return;
    if (item.quantity > 1) { item.quantity--; } else { _cartItems.remove(item); }
    notifyListeners();
  }

  void clearCart() {
    if (_cartItems.isEmpty) return;
    _cartItems.clear();
    notifyListeners();
  }

  void placeOrderAndEarnPoints() {
    final total = cartTotal;
    final earned = (total ~/ 10000); // 1 point per 10K
    final description = '${_cartItems.map((i) => i.drink.name).join(', ')}';
    clearCart();
    addLoyaltyPoints(earned, description);
  }
}

class UserModel {
  final String name, email, avatarLetter, provider;
  const UserModel({required this.name, required this.email,
    required this.avatarLetter, required this.provider});
}

// ════════════════════════════════════════════════════════════
// STATIC DATA
// ════════════════════════════════════════════════════════════
class DrinkData {
  static const List<Drink> drinks = [
    Drink(id:'D001', name:'Caramel Frappuccino',   emoji:'🧋', category:'Frappuccino',  caffeine:'Trung bình', description:'Caramel + Espresso + Kem tươi',   price:79000, isBestSeller:true),
    Drink(id:'D002', name:'Green Tea Frappuccino', emoji:'🍵', category:'Frappuccino',  caffeine:'Thấp',       description:'Matcha Nhật Bản + Sữa + Kem',    price:79000, isBestSeller:true),
    Drink(id:'D003', name:'Caramel Macchiato',     emoji:'☕', category:'Espresso',     caffeine:'Cao',        description:'Espresso + Sữa + Sốt Caramel',   price:85000),
    Drink(id:'D004', name:'Java Chip Frappuccino', emoji:'🍫', category:'Frappuccino',  caffeine:'Trung bình', description:'Chocolate chip + Đá xay + Kem',  price:85000),
    Drink(id:'D005', name:'Cold Brew',             emoji:'🫗', category:'Cold Coffee',  caffeine:'Cao',        description:'Ủ lạnh 20h – mượt mà, ít chua', price:75000),
    Drink(id:'D006', name:'Iced Matcha Latte',     emoji:'🌿', category:'Teavana',      caffeine:'Thấp',       description:'Matcha + Sữa tươi + Đá',         price:80000),
  ];

  static List<String> get categories =>
      [t('all'), ...drinks.map((d) => d.category).toSet()];
}

// ════════════════════════════════════════════════════════════
// THEME
// ════════════════════════════════════════════════════════════
const kGreen     = Color(0xFF00704A);
const kGreenDark = Color(0xFF004F35);
const kGold      = Color(0xFFCBA258);
const kBg        = Color(0xFFF1F8F5);
const kCard      = Color(0xFFFFFFFF);

// ════════════════════════════════════════════════════════════
// APP ROOT
// ════════════════════════════════════════════════════════════
class StarbucksApp extends StatelessWidget {
  const StarbucksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Starbucks Vietnam',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
            fontFamily: 'Roboto',
          ),
          home: AppState().isLoggedIn ? const MainShell() : const AuthScreen(),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════
// AUTH SCREEN
// ════════════════════════════════════════════════════════════
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  bool _obscure = true, _loading = false;

  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  final _nameCtrl   = TextEditingController();
  final _emailRCtrl = TextEditingController();
  final _passRCtrl  = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _emailCtrl.dispose(); _passCtrl.dispose();
    _nameCtrl.dispose(); _emailRCtrl.dispose(); _passRCtrl.dispose();
    super.dispose();
  }

  void _setLoading(bool v) {
    if (!mounted || _loading == v) return;
    setState(() => _loading = v);
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg), backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  void _showSuccess(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg), backgroundColor: kGreen,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  String _firstLetter(String? v, String fallback) {
    final s = (v ?? '').trim();
    return (s.isNotEmpty ? s[0] : fallback).toUpperCase();
  }

  void _loginFirebaseUser(User user, {required String provider, required String fallbackName}) {
    final name = (user.displayName?.trim().isNotEmpty ?? false) ? user.displayName!.trim() : fallbackName;
    AppState().login(UserModel(
      name: name, email: user.email ?? '',
      avatarLetter: _firstLetter(name, provider[0]), provider: provider,
    ));
  }

  void _handleAuthException(FirebaseAuthException e, String action) {
    final msgs = <String, String>{
      'email-already-in-use': 'Email đã được sử dụng',
      'invalid-email': 'Email không hợp lệ',
      'user-disabled': 'Tài khoản đã bị vô hiệu hoá',
      'user-not-found': 'Email chưa được đăng ký',
      'wrong-password': 'Mật khẩu không đúng',
      'weak-password': 'Mật khẩu quá yếu',
    };
    _showError(msgs[e.code] ?? '$action thất bại: ${e.message ?? e.code}');
  }

  Future<void> _loginWithGoogle() async {
    _setLoading(true);
    try {
      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        _showError('Thiết bị/nền tảng này chưa hỗ trợ Google Sign-In trực tiếp.');
        return;
      }
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      final result = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = result.user;
      if (user == null) { _showError('Không lấy được thông tin tài khoản Google'); return; }
      _loginFirebaseUser(user, provider: 'google', fallbackName: googleUser.displayName ?? 'Google User');
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e, 'Google login');
    } catch (e) {
      _showError('Google login thất bại: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loginWithFacebook() async {
    _setLoading(true);
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.cancelled) return;
      if (result.status != LoginStatus.success || result.accessToken == null) {
        _showError('Facebook login thất bại: ${result.message ?? 'Không lấy được access token'}');
        return;
      }
      final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final fbResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = fbResult.user;
      if (user == null) { _showError('Không lấy được thông tin tài khoản Facebook'); return; }
      _loginFirebaseUser(user, provider: 'facebook', fallbackName: user.displayName ?? 'Facebook User');
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e, 'Facebook login');
    } catch (e) {
      _showError('Facebook login thất bại: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loginWithEmail() async {
    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;
    if (email.isEmpty || password.isEmpty) { _showError('Vui lòng nhập email và mật khẩu'); return; }
    _setLoading(true);
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      if (user == null) { _showError('Không lấy được thông tin người dùng'); return; }
      _loginFirebaseUser(user, provider: 'email', fallbackName: email.split('@').first);
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e, 'Đăng nhập');
    } catch (e) {
      _showError('Lỗi: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _registerWithEmail() async {
    final name = _nameCtrl.text.trim();
    final email = _emailRCtrl.text.trim();
    final password = _passRCtrl.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) { _showError('Vui lòng điền đầy đủ thông tin'); return; }
    if (password.length < 6) { _showError('Mật khẩu phải có ít nhất 6 ký tự'); return; }
    _setLoading(true);
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      if (user == null) { _showError('Không tạo được tài khoản'); return; }
      await user.updateDisplayName(name);
      AppState().login(UserModel(name: name, email: email, avatarLetter: _firstLetter(name, 'E'), provider: 'email'));
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e, 'Đăng ký');
    } catch (e) {
      _showError('Lỗi: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) { _showError('Nhập email để reset mật khẩu'); return; }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSuccess('Đã gửi email reset đến $email');
    } catch (e) {
      _showError('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [kGreenDark, kGreen],
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 32),
              const Text('☕', style: TextStyle(fontSize: 52)),
              const SizedBox(height: 8),
              Text(t('app_name'), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(t('welcome_back'), style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: kCard, borderRadius: BorderRadius.circular(28),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 24, offset: const Offset(0, 8))],
                  ),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      decoration: BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(14)),
                      child: TabBar(
                        controller: _tabCtrl,
                        indicator: BoxDecoration(color: kGreen, borderRadius: BorderRadius.circular(12)),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey.shade600,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        dividerColor: Colors.transparent,
                        tabs: [Tab(text: t('login')), Tab(text: t('register'))],
                      ),
                    ),
                    SizedBox(
                      height: 440,
                      child: TabBarView(
                        controller: _tabCtrl,
                        children: [_buildLoginTab(), _buildRegisterTab()],
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(children: [
                  Row(children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(t('or_login_with'), style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(child: _SocialButton(
                      label: 'Google', emoji: '🔴',
                      color: const Color(0xFFEA4335), bgColor: const Color(0xFFFEF2F2),
                      onTap: _loginWithGoogle,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _SocialButton(
                      label: 'Facebook', emoji: '🔵',
                      color: const Color(0xFF1877F2), bgColor: const Color(0xFFEFF6FF),
                      onTap: _loginWithFacebook,
                    )),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
        if (_loading)
          Container(
            color: Colors.black.withValues(alpha: 0.35),
            child: const Center(child: CircularProgressIndicator(color: kGreen)),
          ),
      ]),
    );
  }

  Widget _buildLoginTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const SizedBox(height: 8),
        _AuthField(controller: _emailCtrl, label: t('email'), icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 14),
        _AuthField(controller: _passCtrl, label: t('password'), icon: Icons.lock_outline,
            obscure: _obscure,
            suffix: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade500, size: 20),
              onPressed: () => setState(() => _obscure = !_obscure),
            )),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: _forgotPassword,
            child: Text(t('forgot_password'),
                style: const TextStyle(color: kGreen, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 4),
        _GreenButton(label: t('login'), onTap: _loginWithEmail),
      ]),
    );
  }

  Widget _buildRegisterTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const SizedBox(height: 8),
        _AuthField(controller: _nameCtrl, label: t('full_name'), icon: Icons.person_outline),
        const SizedBox(height: 12),
        _AuthField(controller: _emailRCtrl, label: t('email'), icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 12),
        _AuthField(controller: _passRCtrl, label: t('password_hint'),
            icon: Icons.lock_outline, obscure: true),
        const SizedBox(height: 20),
        _GreenButton(label: t('create_account'), onTap: _registerWithEmail),
        const SizedBox(height: 12),
        Text(t('terms'), textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ════════════════════════════════════════════════════════════
class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _AuthField({required this.controller, required this.label, required this.icon,
    this.obscure = false, this.keyboardType, this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, obscureText: obscure, keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: label, prefixIcon: Icon(icon, color: kGreen, size: 20),
        suffixIcon: suffix, filled: true, fillColor: kBg,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: kGreen, width: 1.5)),
        labelStyle: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class _GreenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GreenButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreen, foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label, emoji;
  final Color color, bgColor;
  final VoidCallback onTap;
  const _SocialButton({required this.label, required this.emoji, required this.color,
    required this.bgColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ]),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// MAIN SHELL
// ════════════════════════════════════════════════════════════
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

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
  void dispose() { _fadeCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(), const ContentScreen(), const CartScreen(), const AboutScreen(),
    ];
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) => Scaffold(
        backgroundColor: kBg,
        extendBody: true,
        body: FadeTransition(opacity: _fadeAnim, child: screens[_currentIndex]),
        bottomNavigationBar: _LiquidGlassNavBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          cartCount: AppState().cartCount,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// LIQUID GLASS NAVIGATION BAR
// ════════════════════════════════════════════════════════════
class _LiquidGlassNavBar extends StatelessWidget {
  final int currentIndex, cartCount;
  final ValueChanged<int> onTap;

  const _LiquidGlassNavBar({required this.currentIndex, required this.onTap, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home_rounded,          activeIcon: Icons.home_rounded,          label: t('home')),
      _NavItem(icon: Icons.grid_view_rounded,      activeIcon: Icons.grid_view_rounded,      label: t('content')),
      _NavItem(icon: Icons.shopping_cart_outlined, activeIcon: Icons.shopping_cart_rounded,  label: t('cart')),
      _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded,         label: t('about')),
    ];
    final bottom = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: bottom + 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1),
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Colors.white.withValues(alpha: 0.28), Colors.white.withValues(alpha: 0.10)],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, (i) => _NavTab(
                item: items[i], isActive: currentIndex == i,
                onTap: () => onTap(i),
                badge: i == 2 && cartCount > 0 ? cartCount : null,
              )),
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
  final int? badge;
  const _NavTab({required this.item, required this.isActive, required this.onTap, this.badge});
  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _pill;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
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
        builder: (_, __) => SizedBox(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizeTransition(
                    sizeFactor: _pill, axis: Axis.horizontal, axisAlignment: 0,
                    child: Container(
                      width: 52, height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: kGreen.withValues(alpha: 0.20),
                        border: Border.all(color: kGreen.withValues(alpha: 0.35), width: 0.8),
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
                  if (widget.badge != null)
                    Positioned(
                      top: -4, right: -4,
                      child: Container(
                        width: 16, height: 16,
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text('${widget.badge}',
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
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
        ),
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
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = t('all');
  }

  List<Drink> get _filtered {
    if (_selectedCategory == t('all') || _selectedCategory == 'Tất cả' || _selectedCategory == 'All') {
      return DrinkData.drinks;
    }
    return DrinkData.drinks.where((d) => d.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = AppState().currentUser;
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final cats = DrinkData.categories;
        return Scaffold(
          backgroundColor: kBg,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 140, floating: false, pinned: true, backgroundColor: kGreen,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                          colors: [kGreen, kGreenDark]),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            const Text('★', style: TextStyle(color: kGold, fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(t('app_name'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                              child: Row(children: [
                                const Icon(Icons.location_on, color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(t('location'), style: const TextStyle(color: Colors.white, fontSize: 12)),
                              ]),
                            ),
                          ]),
                          const SizedBox(height: 8),
                          Text('${t('greeting')}, ${user?.name ?? t('guest')}! ${t('what_drink')}',
                              style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Banner
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Container(
                      width: double.infinity, padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF1B5E3A), Color(0xFF00704A)]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: kGreen.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: kGold.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(8)),
                            child: Text(t('today_offer'), style: const TextStyle(color: kGold, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 8),
                          Text(t('discount'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.2)),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, foregroundColor: kGreen,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              elevation: 0,
                            ),
                            child: Text(t('see_now'), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ])),
                        const Text('🧋', style: TextStyle(fontSize: 64)),
                      ]),
                    ),
                  ),
                  // Points teaser banner
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoyaltyScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [kGold.withValues(alpha: 0.15), kGold.withValues(alpha: 0.05)]),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: kGold.withValues(alpha: 0.4)),
                        ),
                        child: Row(children: [
                          const Text('⭐', style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(t('loyalty_points'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF7A5C00))),
                            Text('${AppState().loyaltyPoints} ${t('stars')} · ${AppState().memberTier}',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF9A7B00))),
                          ])),
                          const Icon(Icons.chevron_right, color: kGold, size: 20),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cats.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final cat = cats[i];
                        final active = cat == _selectedCategory ||
                            (i == 0 && (_selectedCategory.isEmpty || _selectedCategory == t('all')));
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
                            child: Text(cat, style: TextStyle(
                                color: active ? Colors.white : Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: active ? FontWeight.bold : FontWeight.normal)),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                    child: Row(children: [
                      Text(t('menu'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
                      const Spacer(),
                      Text('${_filtered.length} ${t('items')}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ]),
                  ),
                ]),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (_, i) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _DrinkCard(drink: _filtered[i])),
                    childCount: _filtered.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DrinkCard extends StatelessWidget {
  final Drink drink;
  const _DrinkCard({required this.drink});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final inCart = AppState().cartItems.any((i) => i.drink.id == drink.id);
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kCard, borderRadius: BorderRadius.circular(18),
            border: const Border(left: BorderSide(color: kGreen, width: 4)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Row(children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.08), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(drink.emoji, style: const TextStyle(fontSize: 28)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Flexible(child: Text(drink.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis)),
                if (drink.isBestSeller) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFFFF3CD), borderRadius: BorderRadius.circular(6)),
                    child: Text('★ ${t('best_seller')}', style: const TextStyle(fontSize: 9, color: Color(0xFFB8860B), fontWeight: FontWeight.bold)),
                  ),
                ],
              ]),
              const SizedBox(height: 3),
              Text(drink.description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              const SizedBox(height: 6),
              Row(children: [
                _Chip(drink.category, kGreen),
                const SizedBox(width: 6),
                _Chip('Caffeine: ${drink.caffeine}',
                    drink.caffeine == 'Cao' || drink.caffeine == 'High' ? Colors.red.shade400 : Colors.green.shade600),
              ]),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(drink.formattedPrice, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown.shade700)),
              const Text('Tall', style: TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  AppState().addToCart(drink);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${t('added_to_cart')} ${drink.name} ${t('to_cart')}'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: kGreen, behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: inCart ? Colors.orange : kGreen, shape: BoxShape.circle),
                  child: Icon(inCart ? Icons.check : Icons.add, color: Colors.white, size: 14),
                ),
              ),
            ]),
          ]),
        );
      },
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
      decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.2))),
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
    final drinks      = DrinkData.drinks;
    final minPrice    = drinks.map((d) => d.price).reduce((a, b) => a < b ? a : b);
    final maxPrice    = drinks.map((d) => d.price).reduce((a, b) => a > b ? a : b);
    final bestSellers = drinks.where((d) => d.isBestSeller).toList();
    final categories  = drinks.map((d) => d.category).toSet();

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kGreen,
        title: Text(t('content_title'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true, elevation: 0,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: Colors.white.withValues(alpha: 0.15))),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        children: [
          _SectionTitle(t('overview')),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.8,
            children: [
              _StatCard(icon: Icons.coffee,                label: t('total_drinks'),   value: '${drinks.length}',      color: kGreen),
              _StatCard(icon: Icons.star_rounded,          label: t('best_seller'),    value: '${bestSellers.length}', color: kGold),
              _StatCard(icon: Icons.trending_down_rounded, label: t('lowest_price'),   value: '${minPrice ~/ 1000}K',  color: Colors.blue.shade600),
              _StatCard(icon: Icons.trending_up_rounded,   label: t('highest_price'),  value: '${maxPrice ~/ 1000}K',  color: Colors.orange.shade700),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle(t('categories')),
          const SizedBox(height: 10),
          ...categories.map((cat) {
            final count = drinks.where((d) => d.category == cat).length;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200)),
              child: Row(children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: kGreen, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                Text(cat, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: Text('$count ${t('items')}', style: const TextStyle(color: kGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ]),
            );
          }),
          const SizedBox(height: 24),
          _SectionTitle(t('data_model')),
          const SizedBox(height: 10),
          _InfoCard(icon: Icons.code_rounded, title: 'Drink.dart',
              subtitle: '9 biến · 6 phương thức · 2 static methods',
              tags: const ['id', 'name', 'price', 'emoji', 'category', 'isBestSeller']),
          const SizedBox(height: 8),
          _InfoCard(icon: Icons.list_alt_rounded, title: 'ListDrink.dart',
              subtitle: 'CRUD đầy đủ: Create / Read / Edit / Delete',
              tags: const ['create()', 'readAll()', 'edit()', 'delete()', 'findById()']),
          const SizedBox(height: 8),
          _InfoCard(icon: Icons.shopping_cart_rounded, title: 'Cart.dart + CartItem.dart',
              subtitle: 'Quản lý giỏ hàng, tính tổng tiền',
              tags: const ['addItem()', 'removeItem()', 'totalAmount']),
          const SizedBox(height: 24),
          _SectionTitle(t('knowledge')),
          const SizedBox(height: 10),
          const _TechRow(icon: '⚡', title: 'static',   desc: 'DrinkData, maxOrderQuantity dùng chung toàn app'),
          const _TechRow(icon: '🔷', title: 'Generics', desc: 'Container<T> bọc dữ liệu đồ uống'),
          const _TechRow(icon: '🏗️', title: 'OOP',      desc: 'Drink, ListDrink, Cart, Order, User'),
          const _TechRow(icon: '📱', title: 'Flutter',  desc: 'Material 3, Navigator, Liquid Glass NavBar'),
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
        color: kCard, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        ]),
      ]),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) =>
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B4332)));
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
      decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, color: kGreen, size: 20), const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        const SizedBox(height: 8),
        Wrap(spacing: 6, runSpacing: 4, children: tags.map((t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6)),
          child: Text(t, style: const TextStyle(fontSize: 10, color: kGreen, fontWeight: FontWeight.w600)),
        )).toList()),
      ]),
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
      decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        ])),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SCREEN 3: CART
// ════════════════════════════════════════════════════════════
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final items   = AppState().cartItems;
        final isEmpty = items.isEmpty;
        return Scaffold(
          backgroundColor: kBg,
          appBar: AppBar(
            backgroundColor: kGreen,
            title: Text(t('my_cart'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            centerTitle: true, elevation: 0,
            actions: [
              if (!isEmpty)
                TextButton(
                  onPressed: () => _showClearConfirm(context),
                  child: Text(t('delete_all'), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
            ],
          ),
          body: isEmpty ? _buildEmpty() : _buildCart(context, items),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 100, height: 100,
            decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.08), shape: BoxShape.circle),
            child: const Center(child: Text('🛒', style: TextStyle(fontSize: 44)))),
        const SizedBox(height: 20),
        Text(t('empty_cart'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
        const SizedBox(height: 8),
        Text(t('add_drinks'), style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
      ]),
    );
  }

  Widget _buildCart(BuildContext context, List<CartItem> items) {
    const deliveryFee = 15000;
    final subtotal    = AppState().cartTotal;
    final total       = subtotal + deliveryFee;

    return Column(children: [
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => _CartItemCard(item: items[i]),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).padding.bottom + 90),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: kGreen.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kGreen.withValues(alpha: 0.2)),
            ),
            child: Row(children: [
              const Icon(Icons.local_offer_outlined, color: kGreen, size: 18),
              const SizedBox(width: 10),
              Text(t('promo_code'), style: const TextStyle(fontSize: 13, color: kGreen)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: kGreen, size: 18),
            ]),
          ),
          const SizedBox(height: 16),
          _PriceRow('${t('subtotal')} (${items.fold(0, (s, i) => s + i.quantity)} ${t('items')})', '${subtotal ~/ 1000}K'),
          const SizedBox(height: 6),
          _PriceRow(t('delivery_fee'), '${deliveryFee ~/ 1000}K'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider()),
          Row(children: [
            Text(t('total'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
            const Spacer(),
            Text('${total ~/ 1000}K', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kGreen)),
          ]),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: () => _showOrderSuccess(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreen, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.shopping_bag_outlined, size: 20),
                const SizedBox(width: 8),
                Text('${t('order')} · ${total ~/ 1000}K',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ]),
            ),
          ),
        ]),
      ),
    ]);
  }

  void _showClearConfirm(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(t('clear_cart')),
      content: Text(t('clear_confirm')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context),
            child: Text(t('cancel'), style: TextStyle(color: Colors.grey.shade600))),
        ElevatedButton(
          onPressed: () { AppState().clearCart(); Navigator.pop(context); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: Text(t('delete')),
        ),
      ],
    ));
  }

  void _showOrderSuccess(BuildContext context) {
    final earnedPoints = AppState().cartTotal ~/ 10000;
    showDialog(context: context, barrierDismissible: false, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 8),
        Container(width: 72, height: 72,
            decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Center(child: Text('✅', style: TextStyle(fontSize: 36)))),
        const SizedBox(height: 16),
        Text(t('order_success'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
        const SizedBox(height: 8),
        Text(t('order_brewing'), textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: kGold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kGold.withValues(alpha: 0.3))),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text('⭐', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text('+$earnedPoints ${t('stars')}', style: const TextStyle(color: Color(0xFF7A5C00), fontWeight: FontWeight.bold, fontSize: 14)),
          ]),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () { AppState().placeOrderAndEarnPoints(); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text(t('great')),
          ),
        ),
      ]),
    ));
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCard, borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Container(width: 52, height: 52,
            decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.08), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(item.drink.emoji, style: const TextStyle(fontSize: 26))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.drink.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text('${item.drink.formattedPrice} · ${item.size}', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(height: 6),
          Text(item.formattedSubtotal, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kGreen)),
        ])),
        Column(children: [
          GestureDetector(
            onTap: () => AppState().removeFromCart(item.drink.id),
            child: Container(padding: const EdgeInsets.all(4),
                child: Icon(Icons.delete_outline, color: Colors.red.shade300, size: 18)),
          ),
          const SizedBox(height: 8),
          Row(children: [
            _QtyBtn(icon: Icons.remove, onTap: () => AppState().decreaseQty(item.drink.id)),
            Container(width: 30, alignment: Alignment.center,
                child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            _QtyBtn(icon: Icons.add, onTap: () => AppState().increaseQty(item.drink.id)),
          ]),
        ]),
      ]),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28, height: 28,
        decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kGreen.withValues(alpha: 0.25))),
        child: Icon(icon, size: 14, color: kGreen),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label, value;
  const _PriceRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
      const Spacer(),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    ]);
  }
}

// ════════════════════════════════════════════════════════════
// SCREEN 4: ABOUT / PROFILE
// ════════════════════════════════════════════════════════════
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _members = [
    {'name': 'Nguyễn Văn A', 'mssv': 'SV123456', 'role': 'Leader',    'task': 'UI/UX + AppBar'},
    {'name': 'Trần Thị B',   'mssv': 'SV234567', 'role': 'Developer', 'task': 'Drink.dart + CRUD'},
    {'name': 'Lê Văn C',     'mssv': 'SV345678', 'role': 'Developer', 'task': 'Cart + Order'},
  ];

  @override
  Widget build(BuildContext context) {
    final user = AppState().currentUser;
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) => Scaffold(
        backgroundColor: kBg,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: 180, pinned: true, backgroundColor: kGreen,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                tooltip: t('settings'),
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () => _confirmLogout(context),
                tooltip: t('logout'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [kGreenDark, kGreen])),
                child: SafeArea(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      width: 68, height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                      ),
                      child: Center(child: Text(user?.avatarLetter ?? '?',
                          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(height: 8),
                    Text(user?.name ?? t('guest'),
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(user?.email ?? '', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 4),
                    if (user?.provider != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          user!.provider == 'google' ? '🔴 Google' : user.provider == 'facebook' ? '🔵 Facebook' : '📧 Email',
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                  ]),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick actions row
                Row(children: [
                  Expanded(child: _QuickActionCard(
                    icon: '⭐',
                    label: t('loyalty_points'),
                    value: '${AppState().loyaltyPoints} ${t('stars')}',
                    color: kGold,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoyaltyScreen())),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _QuickActionCard(
                    icon: '⚙️',
                    label: t('settings'),
                    value: AppStrings.isVietnamese ? '🇻🇳 VI' : '🇺🇸 EN',
                    color: kGreen,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                  )),
                ]),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Column(children: [
                    _AboutRow(t('subject'),   'Lập trình Mobile'),
                    _AboutRow(t('framework'), 'Flutter 3.x + Dart'),
                    _AboutRow(t('design'),    'Material 3 + Liquid Glass'),
                    _AboutRow('GitHub',       'github.com/nhóm/starbucks'),
                    _AboutRow(t('updated'),   '05/2026'),
                  ]),
                ),
                const SizedBox(height: 20),
                _SectionTitle(t('members')),
                const SizedBox(height: 10),
                ..._members.asMap().entries.map((e) {
                  final idx = e.key;
                  final m   = e.value;
                  const colors = [kGreen, kGold, Color(0xFF5C4A1E)];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))]),
                    child: Row(children: [
                      Container(width: 48, height: 48, decoration: BoxDecoration(color: colors[idx], shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(m['name']![0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: colors[idx].withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                            child: Text(m['role']!, style: TextStyle(fontSize: 10, color: colors[idx], fontWeight: FontWeight.bold)),
                          ),
                        ]),
                        const SizedBox(height: 3),
                        Text('MSSV: ${m['mssv']}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                        Text('${t('task')}: ${m['task']}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                      ])),
                    ]),
                  );
                }),
                const SizedBox(height: 20),
                _SectionTitle(t('tech_stack')),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: ['Flutter 3.x', 'Dart 3.x', 'Material 3', 'Firebase Auth',
                    'Google Sign-In', 'Facebook Auth', 'Liquid Glass', 'OOP',
                    'static', 'Generics', 'CRUD', 'Navigator', 'GitHub',
                    'QR Loyalty', 'i18n VI/EN',
                  ].map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: kGreen.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kGreen.withValues(alpha: 0.2))),
                    child: Text(tag, style: const TextStyle(fontSize: 12, color: kGreen, fontWeight: FontWeight.w600)),
                  )).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmLogout(context),
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: Text(t('logout'), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(t('logout_q')),
      content: Text(t('logout_confirm')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context),
            child: Text(t('cancel'), style: TextStyle(color: Colors.grey.shade600))),
        ElevatedButton(
          onPressed: () async { Navigator.pop(context); await AppState().logout(); },
          style: ElevatedButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: Text(t('logout')),
        ),
      ],
    ));
  }
}

class _QuickActionCard extends StatelessWidget {
  final String icon, label, value;
  final Color color;
  final VoidCallback onTap;
  const _QuickActionCard({required this.icon, required this.label, required this.value, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kCard, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.25)),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
        ]),
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
      child: Row(children: [
        Text(key1, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
// LOYALTY / QR SCREEN  (mới)
// ════════════════════════════════════════════════════════════
class LoyaltyScreen extends StatefulWidget {
  const LoyaltyScreen({super.key});
  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    if (AppState().qrCode.isEmpty) AppState().generateQR();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.95, end: 1.05).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _pulseCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final state = AppState();
        final progress = state.loyaltyPoints >= 300
            ? (state.loyaltyPoints - 300) / (500 - 300)
            : state.loyaltyPoints / 300.0;

        return Scaffold(
          backgroundColor: kBg,
          appBar: AppBar(
            backgroundColor: kGreen,
            title: Text(t('loyalty_points'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            child: Column(children: [
              // Tier card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: state.loyaltyPoints >= 300
                        ? [const Color(0xFF8B6914), kGold]
                        : [kGreenDark, kGreen],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(
                    color: (state.loyaltyPoints >= 300 ? kGold : kGreen).withValues(alpha: 0.4),
                    blurRadius: 20, offset: const Offset(0, 8),
                  )],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Text('⭐', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(state.memberTier, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(state.currentUser?.name ?? t('guest'), style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ]),
                    const Spacer(),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('${state.loyaltyPoints}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
                      Text(t('stars'), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ]),
                  ]),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${t('next_reward')}: ${state.pointsToNextReward} ${t('stars')}',
                      style: const TextStyle(color: Colors.white70, fontSize: 11)),
                ]),
              ),

              const SizedBox(height: 24),

              // QR Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kCard, borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Column(children: [
                  Text(t('my_qr'), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
                  const SizedBox(height: 6),
                  Text(t('qr_instruction'), textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500, height: 1.5)),
                  const SizedBox(height: 20),

                  // QR visual (custom drawn — no package needed)
                  ScaleTransition(
                    scale: _pulseAnim,
                    child: Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kGreen, width: 3),
                        boxShadow: [BoxShadow(color: kGreen.withValues(alpha: 0.2), blurRadius: 16, spreadRadius: 2)],
                      ),
                      child: CustomPaint(
                        painter: _QRPainter(code: AppState().qrCode),
                        child: Center(
                          child: Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: const Center(child: Text('☕', style: TextStyle(fontSize: 26))),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Code display
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: kBg, borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kGreen.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      _formatCode(AppState().qrCode),
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 15, fontWeight: FontWeight.bold, color: kGreenDark, letterSpacing: 3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => AppState().generateQR(),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: Text(t('refresh_qr')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kGreen, side: const BorderSide(color: kGreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ]),
              ),

              const SizedBox(height: 24),

              // Points history
              Align(alignment: Alignment.centerLeft,
                  child: Text(t('history_points'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B4332)))),
              const SizedBox(height: 12),
              ...AppState().pointHistory.map((tx) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Row(children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: kGold.withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: const Center(child: Text('⭐', style: TextStyle(fontSize: 18))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(tx.description, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), overflow: TextOverflow.ellipsis),
                    Text(_formatDate(tx.date), style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: kGold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                    child: Text('+${tx.points}', style: const TextStyle(color: Color(0xFF7A5C00), fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ]),
              )),
            ]),
          ),
        );
      },
    );
  }

  String _formatCode(String code) {
    if (code.length < 16) return code;
    return '${code.substring(0, 4)} ${code.substring(4, 8)} ${code.substring(8, 12)} ${code.substring(12, 16)}';
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;
    if (diff == 0) return AppStrings.isVietnamese ? 'Hôm nay' : 'Today';
    if (diff == 1) return AppStrings.isVietnamese ? 'Hôm qua' : 'Yesterday';
    return AppStrings.isVietnamese ? '$diff ngày trước' : '$diff days ago';
  }
}

/// Draws a simplified QR-like pattern from the code string
class _QRPainter extends CustomPainter {
  final String code;
  const _QRPainter({required this.code});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = kGreenDark;
    final rng = code.codeUnits;
    const margin = 14.0;
    const modules = 14;
    final cellSize = (size.width - margin * 2) / modules;

    // Corner finder patterns (3 corners)
    void drawFinder(double x, double y) {
      // Outer
      canvas.drawRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, cellSize * 7, cellSize * 7), const Radius.circular(4)), paint);
      // White inner
      canvas.drawRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(x + cellSize, y + cellSize, cellSize * 5, cellSize * 5),
          const Radius.circular(2)), Paint()..color = Colors.white);
      // Inner dot
      canvas.drawRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(x + cellSize * 2, y + cellSize * 2, cellSize * 3, cellSize * 3),
          const Radius.circular(2)), paint);
    }

    drawFinder(margin, margin);
    drawFinder(size.width - margin - cellSize * 7, margin);
    drawFinder(margin, size.height - margin - cellSize * 7);

    // Data modules
    for (int r = 0; r < modules; r++) {
      for (int c = 0; c < modules; c++) {
        // Skip finder pattern zones
        if ((r < 8 && c < 8) || (r < 8 && c >= modules - 7) || (r >= modules - 7 && c < 8)) continue;
        final idx = (r * modules + c) % rng.length;
        if ((rng[idx] + r + c) % 3 == 0) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(margin + c * cellSize + 1, margin + r * cellSize + 1, cellSize - 2, cellSize - 2),
              const Radius.circular(1.5),
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_QRPainter old) => old.code != code;
}

// ════════════════════════════════════════════════════════════
// SETTINGS SCREEN  (mới)
// ════════════════════════════════════════════════════════════
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final state = AppState();
        return Scaffold(
          backgroundColor: kBg,
          appBar: AppBar(
            backgroundColor: kGreen,
            title: Text(t('settings'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            children: [
              // Language section
              _SettingsSection(title: t('language'), children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Column(children: [
                    _LangOption(
                      flag: '🇻🇳',
                      label: t('language_vi'),
                      selected: AppStrings.isVietnamese,
                      onTap: () => state.setLanguage(true),
                    ),
                    const Divider(height: 16),
                    _LangOption(
                      flag: '🇺🇸',
                      label: t('language_en'),
                      selected: !AppStrings.isVietnamese,
                      onTap: () => state.setLanguage(false),
                    ),
                  ]),
                ),
              ]),
              const SizedBox(height: 20),

              // Notifications & sound
              _SettingsSection(title: AppStrings.isVietnamese ? 'Thông báo & Âm thanh' : 'Notifications & Sound', children: [
                Container(
                  decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Column(children: [
                    _SettingsTile(
                      icon: Icons.notifications_outlined,
                      label: t('notifications'),
                      trailing: Switch(value: state.notificationsOn, onChanged: (_) => state.toggleNotifications(),
                          activeColor: kGreen),
                    ),
                    Divider(height: 1, color: Colors.grey.shade200),
                    _SettingsTile(
                      icon: Icons.volume_up_outlined,
                      label: t('sound'),
                      trailing: Switch(value: state.soundOn, onChanged: (_) => state.toggleSound(),
                          activeColor: kGreen),
                    ),
                  ]),
                ),
              ]),
              const SizedBox(height: 20),

              // About app
              _SettingsSection(title: t('about_app'), children: [
                Container(
                  decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Column(children: [
                    _SettingsTile(
                      icon: Icons.info_outline_rounded,
                      label: t('version'),
                      trailing: Text('1.0.0', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                    ),
                    Divider(height: 1, color: Colors.grey.shade200),
                    _SettingsTile(
                      icon: Icons.coffee_outlined,
                      label: t('app_name'),
                      trailing: const Text('☕', style: TextStyle(fontSize: 18)),
                    ),
                  ]),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
          color: Colors.grey.shade500, letterSpacing: 1)),
      const SizedBox(height: 8),
      ...children,
    ]);
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  const _SettingsTile({required this.icon, required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Icon(icon, color: kGreen, size: 22),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        trailing,
      ]),
    );
  }
}

class _LangOption extends StatelessWidget {
  final String flag, label;
  final bool selected;
  final VoidCallback onTap;
  const _LangOption({required this.flag, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? kGreen.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? kGreen : Colors.transparent, width: 1.5),
        ),
        child: Row(children: [
          Text(flag, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? kGreen : Colors.grey.shade700))),
          if (selected)
            const Icon(Icons.check_circle_rounded, color: kGreen, size: 20),
        ]),
      ),
    );
  }
}
