
# 🏟️ ĐỒ ÁN LẬP TRÌNH QUẢN LÝ - QUẢN LÝ ĐẶT VÉ SÂN VẬN ĐỘNG

## 👨‍💻 Thông tin nhóm

| Họ và tên | MSSV | Lớp |
| :--- | :---: | :---: |
| **Nguyễn Hoàng Uy** | DTH235812 | DH24TH3 |
| **Lê Đăng Khoa** | DTH235678 | DH24TH2 |

---

## 📘 Môn học

* **Tên môn:** Lập trình QUẢN LÝ / Lập trình cơ sở dữ liệu
* **Đề tài:** Xây dựng hệ thống quản lý đặt vé và vận hành sân vận động thông minh
* **Ngôn ngữ:** C# (.NET)
* **Cơ sở dữ liệu:** Microsoft SQL Server (Quy mô 40 bảng)

---

## 🎯 Mục tiêu đồ án

Xây dựng một hệ thống quản lý quy mô lớn, giải quyết toàn bộ quy trình từ hạ tầng vật lý đến giao dịch tài chính tại sân vận động:
* Áp dụng kiến trúc CSDL phức tạp để tối ưu hóa việc quản lý hàng chục nghìn ghế ngồi.
* Xây dựng quy trình đặt vé an toàn, chống trùng lặp dữ liệu tuyệt đối.
* Tích hợp hệ sinh thái dịch vụ (F&B, quà lưu niệm) và ví điện tử nội bộ.
* Hệ thống hóa công tác bảo trì và an ninh sân vận động.

---

## ✨ Tính năng chính

Hệ thống được thiết kế với các phân hệ chuyên biệt:

### 🔐 Phân hệ Quản trị (Admin)
* **Quản lý hạ tầng:** Cấu hình khán đài, phân khu, sơ đồ ghế 2D/3D.
* **Quản lý lịch trình:** Sắp xếp lịch đấu, giải đấu, quản lý đội bóng.
* **Quản lý nhân sự:** Phân công nhiệm vụ nhân viên, theo dõi ca trực.
* **Thống kê & Báo cáo:** Theo dõi doanh thu vé, dịch vụ và hiệu suất sử dụng sân.

### 🎫 Phân hệ Bán vé & Kiểm soát
* **Đặt vé thông minh:** Giữ chỗ tạm thời, quét mã QR Code để vào cổng.
* **Quản lý giá vé:** Thay đổi giá linh hoạt theo từng trận đấu và vị trí ghế.
* **Kiểm soát vào ra:** Nhật ký soát vé thời gian thực, chống gian lận vé.

### 🛍️ Phân hệ Khách hàng & Dịch vụ
* **Thành viên:** Tích điểm nâng hạng, quản lý ví điện tử cá nhân.
* **Mua sắm:** Đặt các gói Combo đồ ăn và quà lưu niệm kèm theo vé.
* **Thông báo:** Nhận tin tức trận đấu và ưu đãi qua hệ thống thông báo nội bộ.

---

## 🗂️ Danh mục Quản lý (CRUD tiêu biểu)

Hệ thống quản lý chuyên sâu thông qua các Form nghiệp vụ:
* **Quản lý Sơ đồ ghế:** Form xử lý dữ liệu từ bảng `GheNgoi`, `PhanKhu`, `LoaiGhe`.
* **Quản lý Trận đấu:** Điều phối thông tin từ `DoiBong`, `GiaiDau`, `TranDau`.
* **Quản lý Tài chính:** Xử lý giao dịch qua `ViKhachHang`, `DonHang`, `GiaoDich`.
* **Quản lý Bảo trì:** Theo dõi trạng thái tại bảng `TaiSanSan` và `YeuCauBaoTri`.

---

## ⚙️ Công nghệ sử dụng

* **Ngôn ngữ:** C#
* **Giao diện:** Windows Forms (WinForms) / WPF
* **Cơ sở dữ liệu:** Microsoft SQL Server
* **Thư viện kết nối:** ADO.NET / Entity Framework
* **Bảo mật:** Mã hóa mật khẩu Hash, quản lý Device ID cho thiết bị soát vé.

---

## 📊 Sơ đồ kiến trúc dữ liệu

Hệ thống bao gồm **40 bảng** được chuẩn hóa, chia thành 8 nhóm thực thể chính đảm bảo tính toàn vẹn dữ liệu (Referential Integrity) và hiệu năng truy vấn cao.

> [!TIP]
> **Điểm nhấn kỹ thuật:** Hệ thống sử dụng `UNIQUE INDEX` kết hợp `WHERE` clause để đảm bảo nghiệp vụ đặt ghế không bao giờ bị trùng lặp trong môi trường đa người dùng.

---
⭐ *Project by NHoangUy & DangKhoa - 2026*
