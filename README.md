# coffeeshop_quynh_duc_tu_3_2026 


# 22/04/2026
**Nguyễn Văn Quỳnh-19010025**
*BÀI_THỰC_HÀNH _SỐ_3*
Câu 1
1. Từ khóa static là gì?
Trong lập trình hướng đối tượng với Dart, từ khóa static được sử dụng để định nghĩa các thành viên (bao gồm biến và phương thức) thuộc về bản thân lớp (class), thay vì thuộc về các thể hiện (instances/objects) của lớp đó.
Thông thường, khi bạn tạo ra nhiều đối tượng từ một class, mỗi đối tượng sẽ được cấp phát một vùng nhớ riêng để lưu trữ các biến của nó. Tuy nhiên, với thành viên static, Dart chỉ khởi tạo và cấp phát bộ nhớ một lần duy nhất trong suốt vòng đời của chương trình. Vùng nhớ này được chia sẻ chung cho tất cả các đối tượng được tạo ra từ lớp đó. Quan trọng hơn, bạn hoàn toàn có thể truy cập các biến và phương thức static mà không cần phải dùng từ khóa new (hoặc gọi constructor) để khởi tạo đối tượng.

2. Cách sử dụng static
-Để sử dụng, chỉ cần đặt từ khóa static trước kiểu dữ liệu của biến hoặc trước tên phương thức.
-Cú pháp truy cập: TênLớp.tên_thành_phần_static
-Bắt buộc phải gọi thông qua tên Lớp (Class), tuyệt đối không gọi qua đối tượng (Object).
-Khi làm việc với static, có sự phân chia ranh giới rất rõ ràng giữa những gì thuộc về "Lớp" (static) và những gì thuộc về "Đối tượng" (instance/non-static):
-Hàm Static KHÔNG THỂ gọi biến/hàm thông thường.
Bởi vì hàm static tồn tại độc lập với các đối tượng, nó không biết đối tượng nào đang gọi nó. Do đó, bạn không thể sử dụng từ khóa this bên trong một hàm static.
-Hàm/Biến thông thường CÓ THỂ gọi thành phần Static.
Vì thành phần static đã được khởi tạo sẵn trong bộ nhớ chung và tồn tại xuyên suốt chương trình, bất kỳ đối tượng nào cũng có thể nhìn thấy và gọi nó.
3. Ưu và nhược điểm khi sử dụng static
Ưu điểm:
-Tiết kiệm bộ nhớ (Memory Efficiency): Vì các thành viên static chỉ được lưu ở một vùng nhớ duy nhất và không bị nhân bản mỗi khi tạo đối tượng mới, chúng giúp tối ưu hóa tài nguyên đáng kể, đặc biệt khi dùng để lưu trữ các hằng số chung của hệ thống.
-Truy cập nhanh chóng và tiện lợi: Việc không cần tốn chi phí và thời gian để khởi tạo object (Memory Allocation) giúp thao tác nhanh hơn. Điều này khiến static cực kỳ phù hợp để viết các lớp chứa hàm tiện ích (Utility classes/Helper classes), ví dụ như các hàm toán học, xử lý chuỗi, định dạng ngày tháng.
-Dễ dàng chia sẻ trạng thái chung: Giúp các đối tượng khác nhau có thể dễ dàng giao tiếp và chia sẻ một trạng thái chung (ví dụ: đếm tổng số object đã được tạo ra trên toàn hệ thống).
Nhược điểm:
-Gây khó khăn cho quá trình Unit Test: Các phương thức static gắn chặt với bản thân lớp, do đó rất khó để "mock" (làm giả) khi viết test. Điều này làm giảm khả năng kiểm thử độc lập các thành phần trong hệ thống.
-Nguy cơ rủi ro từ Global State (Trạng thái toàn cục): Nếu biến static không phải là hằng số (const hoặc final), nó có thể bị thay đổi giá trị từ bất kỳ đâu trong chương trình. Điều này phá vỡ luồng kiểm soát dữ liệu, gây ra các lỗi tiềm ẩn cực kỳ khó debug (đặc biệt trong các ứng dụng lớn hoặc chạy đa luồng).
Phá vỡ nguyên tắc Lập trình hướng đối tượng (OOP): Việc lạm dụng static sẽ làm mất đi tính đa hình (Polymorphism) vì phương thức static không thể bị override (ghi đè). Hơn nữa, nó làm tăng độ phụ thuộc chặt chẽ (tight coupling) giữa các phần của mã nguồn, khiến code trở nên giống lập trình thủ tục (procedural) thay vì hướng đối tượng thuần túy. 
Câu 2 3 4 đã commit code
