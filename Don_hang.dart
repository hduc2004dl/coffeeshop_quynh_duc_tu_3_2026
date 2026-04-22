import 'main1.dart';
class DonHang {
  String id;
  String tenThucUong;
  int gia;
  String trangThai; 
  DonHang({
    required this.id,
    required this.tenThucUong,
    required this.gia,
    required this.trangThai,
  });  
  void hienThiThongTin() {
    print('ID: $id | Món: $tenThucUong | Giá: ${gia}k | Trạng thái: $trangThai');
  }
  void capNhatTrangThai(String trangThaiMoi) {
    trangThai = trangThaiMoi;
    print('Đơn hàng $id đã cập nhật trạng thái thành: $trangThaiMoi');
  }
}
