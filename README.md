## 📱 Giới thiệu ứng dụng
 
**Starbucks Vietnam App** mô phỏng trải nghiệm đặt đồ uống tại Starbucks, bao gồm:
 
- Xem menu đồ uống với đầy đủ thông tin (tên, giá, danh mục, mức caffeine)
- Thêm đồ uống vào giỏ hàng và đặt hàng
- Quản lý thông tin khách hàng
- Hiển thị vị trí cửa hàng gần nhất
---
 
## 🗂️ Cấu trúc thư mục
 
```
starbucks_app/
├── lib/
│   ├── models/
│   │   ├── Drink.dart          # Đối tượng đồ uống (Câu 3)
│   │   ├── ListDrink.dart      # CRUD danh sách đồ uống (Câu 4)
│   │   ├── Cart.dart           # Giỏ hàng
│   │   ├── CartItem.dart       # Sản phẩm trong giỏ
│   │   ├── Order.dart          # Đơn hàng
│   │   └── User.dart           # Khách hàng
│   ├── screens/
│   │   └── starbucks_menu_screen.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```
## 🎨 Thống nhất thiết kế 

**Để đảm bảo tính chuyên nghiệp theo yêu cầu bài tập nhóm, ứng dụng tuân thủ các quy tắc sau:**

Màu sắc chủ đạo: Starbucks Green (#00704A) được sử dụng xuyên suốt từ AppBar, nút bấm đến các biểu tượng điều hướng.


Màu nền: Sử dụng màu kem nhạt (#F1F8F5) tạo cảm giác nhẹ nhàng, sạch sẽ.

Widget dùng chung:

_SummaryCard: Thẻ tóm tắt thông số (Tổng món, giá, sao).

DrinkRowItem: Thiết kế thẻ đồ uống với vạch màu nhận diện riêng cho từng danh mục.

_Tag: Nhãn hiển thị trạng thái Caffeine và Danh mục sản phẩm.
 
---
 
## 🧩 Mô hình dữ liệu
 
### `Drink` — lib/models/Drink.dart
 
Đối tượng mô tả một loại đồ uống trong menu Starbucks.
 
| Biến | Kiểu | Mô tả |
|------|------|-------|
| `id` | `String` | Mã đồ uống duy nhất — VD: `'D001'` |
| `name` | `String` | Tên đồ uống — VD: `'Caramel Frappuccino'` |
| `price` | `int` | Đơn giá Tall size (VNĐ) — VD: `79000` |
| `emoji` | `String` | Icon hiển thị trên UI — VD: `'🧋'` |
| `category` | `String` | Danh mục: `Frappuccino` / `Espresso` / `Teavana` / `Cold Coffee` |
| `caffeine` | `String` | Mức caffeine: `Cao` / `Trung bình` / `Thấp` |
| `description` | `String` | Mô tả ngắn nguyên liệu |
| `isBestSeller` | `bool` | Hiển thị badge ⭐ Best Seller |
| `isAvailable` | `bool` | Đang bán (`true`) / Tạm ngưng (`false`) |
 
**Phương thức:**
 
| Phương thức | Mô tả |
|-------------|-------|
| `formattedPrice` | Getter: `79000` → `'79K'` |
| `isLowCaffeine` | Getter: kiểm tra caffeine thấp |
| `priceAfterDiscount(int pct)` | Tính giá sau khi giảm % |
| `display()` | In thông tin đầy đủ ra console |
| `toMap()` | Chuyển object → Map (serialize) |
| `Drink.fromMap(map)` | Factory constructor từ Map |
| `static filterByCategory(list, cat)` | Lọc theo danh mục |
| `static getBestSellers(list)` | Lấy danh sách best seller |
 
---
 
### `ListDrink` — lib/models/ListDrink.dart
 
Quản lý danh sách đồ uống với đầy đủ thao tác CRUD.
 
| Phương thức | Thao tác | Mô tả |
|-------------|----------|-------|
| `create(Drink)` | **CREATE** | Thêm 1 đồ uống, kiểm tra trùng ID |
| `readAll()` | **READ** | In toàn bộ danh sách menu |
| `edit(id, {...})` | **UPDATE** | Sửa theo ID, cập nhật từng field |
| `delete(id)` | **DELETE** | Xóa đồ uống theo ID |
| `findById(id)` | Tìm kiếm | Trả về `Drink?` theo ID |
| `filterByCategory(cat)` | Lọc | Lọc đồ uống theo danh mục |
| `getBestSellers()` | Lọc | Lấy các best seller |
 
---
 
### `Cart` & `CartItem`
 
| Class | Biến chính | Mô tả |
|-------|-----------|-------|
| `CartItem` | `drinkName`, `quantity`, `unitPrice` | 1 dòng trong giỏ hàng |
| `Cart` | `List<CartItem> items` | Toàn bộ giỏ hàng, tính `totalAmount` |
 
---
 
### `User`
 
| Biến | Kiểu | Mô tả |
|------|------|-------|
| `id` | `String` | Mã khách hàng |
| `name` | `String` | Họ tên |
| `email` | `String` | Email |
| `phone` | `String` | Số điện thoại |
 
---
 
### `Order`
 
| Biến | Kiểu | Mô tả |
|------|------|-------|
| `orderId` | `String` | Mã đơn hàng |
| `user` | `User` | Khách đặt hàng |
| `items` | `List<CartItem>` | Danh sách món đã đặt |
| `status` | `String` | `pending` / `confirmed` / `done` |
| `createdAt` | `DateTime` | Thời điểm đặt hàng |
 
---
 
## 🍵 Menu đồ uống (dữ liệu mẫu)
 
| ID | Tên | Giá (Tall) | Danh mục | Caffeine | Best Seller |
|----|-----|-----------|----------|----------|-------------|
| D001 | 🧋 Caramel Frappuccino | 79K | Frappuccino | Trung bình | ⭐ |
| D002 | 🍵 Green Tea Cream Frappuccino | 79K | Frappuccino | Thấp | ⭐ |
| D003 | ☕ Caramel Macchiato | 85K | Espresso | Cao | |
| D004 | 🍫 Java Chip Frappuccino | 85K | Frappuccino | Trung bình | |
| D005 | 🫗 Cold Brew | 75K | Cold Coffee | Cao | |
| D006 | 🌿 Iced Matcha Latte | 80K | Teavana | Thấp | |
 
---
## 🗺️ Tính năng Bản đồ (Google Map Section)
Ứng dụng tích hợp một widget mô phỏng vị trí cửa hàng (_GoogleMapSection) giúp khách hàng tìm kiếm địa điểm Starbucks Reserve gần nhất trong bán kính 0.5km.
 
## 🚀 Hướng dẫn chạy project
 
```bash
# Clone repo về máy
git clone https://github.com/<ten-nhom>/starbucks_app.git
 
# Di chuyển vào thư mục project
cd starbucks_app
 
# Cài đặt dependencies
flutter pub get
 
# Chạy ứng dụng
flutter run
```
 
**Yêu cầu môi trường:**
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Android Studio / VS Code
---
