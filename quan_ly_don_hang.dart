import 'Don_hang.dart';
class QuanLyDonHang {
  List<DonHang> danhSachDonHang = [];
  void themDonHang(DonHang donHangMoi) {
    danhSachDonHang.add(donHangMoi);
    print('\n[+] Đã thêm thành công đơn hàng: ${donHangMoi.tenThucUong}');
  }
  void docDanhSach() {
    print('\n--- DANH SÁCH ĐƠN HÀNG HIỆN TẠI ---');
    if (danhSachDonHang.isEmpty) {
      print('Danh sách trống.');
      return;
    }
    for (var don in danhSachDonHang) {
      don.hienThiThongTin();
    }
  }
  void suaDonHang(String idCanSua, String tenMoi, int giaMoi, String trangThaiMoi) {
    int index = danhSachDonHang.indexWhere((don) => don.id == idCanSua);
    if (index != -1) {
      danhSachDonHang[index].tenThucUong = tenMoi;
      danhSachDonHang[index].gia = giaMoi;
      danhSachDonHang[index].trangThai = trangThaiMoi;
      print('\n[~] Đã cập nhật thành công đơn hàng có ID: $idCanSua');
    } else {
      print('\n[!] Lỗi: Không tìm thấy đơn hàng nào có ID: $idCanSua');
    }
  }
}
void main() {
  QuanLyDonHang quanLy = QuanLyDonHang();
  DonHang don1 = DonHang(id: 'DH01', tenThucUong: 'Đen đá', gia: 35, trangThai: 'Đang chờ');
  DonHang don2 = DonHang(id: 'DH02', tenThucUong: 'Bạc xỉu', gia: 30, trangThai: 'Sẵn sàng');
  //Chạy CREATE
  quanLy.themDonHang(don1);
  quanLy.themDonHang(don2);
  //Chạy READ
  quanLy.docDanhSach();
  // Chạy EDIT
  // Giả sử khách hàng muốn đổi món từ Đen đá sang Latte
  quanLy.suaDonHang('DH01', 'Latte Matcha', 50, 'Đang pha');
  quanLy.docDanhSach();
}
