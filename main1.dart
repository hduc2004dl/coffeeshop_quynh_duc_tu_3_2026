import 'package:flutter/material.dart';

void main() {
  runApp(const QuanLyCaPheApp());
}

class QuanLyCaPheApp extends StatelessWidget {
  const QuanLyCaPheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const ManHinhDatHang(),
    );
  }
}

class ManHinhDatHang extends StatelessWidget {
  const ManHinhDatHang({super.key});

  final String tenKhuVuc = "Trạm Cà Phê";
  final int soNguoiPhucVu = 5;
  final double hieusuat = 98.5; // Đơn vị %

  final List<Map<String, dynamic>> danhSachDonHang = const [
    {"ten": "Đen đá", "gia": 35, "trangThai": "Sẵn sàng"},
    {"ten": "Latte Matcha", "gia": 50, "trangThai": "Đang pha"},
    {"ten": "Trà sữa Hoàng Gia", "gia": 45, "trangThai": "Sẵn sàng"},
    {"ten": "Bạc Xỉu", "gia": 30, "trangThai": "Đang chờ"},
  ];

  double get nangLuong => hieusuat; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản Lý Coffee"),
        backgroundColor: const Color(0xFFF4A460), // Changed to the specified hex color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Hiển thị biến đơn lẻ ---
            Text("Địa điểm: $tenKhuVuc", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Nhân viên: $soNguoiPhucVu người"),
            Text("Hiệu suất: $hieusuat%"),
            const Divider(height: 30, thickness: 2),

            const Text("DANH SÁCH ĐƠN HÀNG:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: danhSachDonHang.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> donHang = danhSachDonHang[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.brown.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(donHang['ten'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("Giá: ${donHang['gia']}k VNĐ", style: TextStyle(color: Colors.brown[600])),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.bolt,
                              size: 18,
                              color: (donHang['trangThai'] as String) == "Sẵn sàng" ? Colors.green : Colors.orange,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              donHang['trangThai'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: (donHang['trangThai'] as String) == "Sẵn sàng" ? Colors.green : Colors.orange[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
