-- 1. Xóa database cũ nếu tồn tại và tạo mới
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QuanLySanVanDong')
    DROP DATABASE QuanLySanVanDong;
GO
CREATE DATABASE QuanLySanVanDong;
GO
USE QuanLySanVanDong;
GO

-----------------------------------------------------------
-- NHÓM 1: HẠ TẦNG & SƠ ĐỒ GHẾ (6 BẢNG)
-----------------------------------------------------------
CREATE TABLE KhanDai (
    MaKhanDai INT PRIMARY KEY IDENTITY(1,1),
    TenKhanDai NVARCHAR(50) NOT NULL, 
    SucChua INT
);

CREATE TABLE PhanKhu (
    MaPhanKhu INT PRIMARY KEY IDENTITY(1,1),
    MaKhanDai INT FOREIGN KEY REFERENCES KhanDai(MaKhanDai),
    TenPhanKhu NVARCHAR(50) NOT NULL,
    DuongDanAnhGocNhin VARCHAR(255)
);

CREATE TABLE KhoiGhe (
    MaKhoi INT PRIMARY KEY IDENTITY(1,1),
    MaPhanKhu INT FOREIGN KEY REFERENCES PhanKhu(MaPhanKhu),
    TenKhoi NVARCHAR(20) NOT NULL
);

CREATE TABLE LoaiGhe (
    MaLoaiGhe INT PRIMARY KEY IDENTITY(1,1),
    TenLoaiGhe NVARCHAR(50), 
    GiaCoBan DECIMAL(18,2) NOT NULL
);

CREATE TABLE GheNgoi (
    MaGhe INT PRIMARY KEY IDENTITY(1,1),
    MaKhoi INT FOREIGN KEY REFERENCES KhoiGhe(MaKhoi),
    MaLoaiGhe INT FOREIGN KEY REFERENCES LoaiGhe(MaLoaiGhe),
    SoHang VARCHAR(10),
    SoGhe INT,
    ThuTuVatLy INT,
    ToaDoX INT, ToaDoY INT,
    DangHoatDong BIT DEFAULT 1
);

CREATE TABLE CongRaVao (
    MaCong INT PRIMARY KEY IDENTITY(1,1),
    MaKhanDai INT FOREIGN KEY REFERENCES KhanDai(MaKhanDai),
    TenCong NVARCHAR(20)
);

-----------------------------------------------------------
-- NHÓM 2: ĐỘI BÓNG & LỊCH TRÌNH (4 BẢNG)
-----------------------------------------------------------
CREATE TABLE DoiBong (
    MaDoiBong INT PRIMARY KEY IDENTITY(1,1),
    TenDoiBong NVARCHAR(100) NOT NULL,
    DuongDanLogo VARCHAR(255)
);

CREATE TABLE GiaiDau (
    MaGiaiDau INT PRIMARY KEY IDENTITY(1,1),
    TenGiaiDau NVARCHAR(200),
    MuaGiai VARCHAR(20)
);

CREATE TABLE TranDau (
    MaTranDau INT PRIMARY KEY IDENTITY(1,1),
    MaGiaiDau INT FOREIGN KEY REFERENCES GiaiDau(MaGiaiDau),
    MaDoiNha INT FOREIGN KEY REFERENCES DoiBong(MaDoiBong),
    MaDoiKhach INT FOREIGN KEY REFERENCES DoiBong(MaDoiBong),
    ThoiGianBatDau DATETIME NOT NULL,
    ThoiGianKetThucThucTe DATETIME,
    TrangThaiTranDau NVARCHAR(50)
);

CREATE TABLE LichSuDungSan (
    MaLich INT PRIMARY KEY IDENTITY(1,1),
    MaTranDau INT UNIQUE FOREIGN KEY REFERENCES TranDau(MaTranDau),
    ThoiGianChuanBi DATETIME,
    ThoiGianDonDep DATETIME
);

-----------------------------------------------------------
-- NHÓM 3: KHÁCH HÀNG & HỘI VIÊN (4 BẢNG)
-----------------------------------------------------------
CREATE TABLE HangThanhVien (
    MaHang INT PRIMARY KEY IDENTITY(1,1),
    TenHang NVARCHAR(50),
    PhanTramGiamGia INT DEFAULT 0,
    DiemToiThieu INT DEFAULT 0
);

CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY IDENTITY(1,1),
    MaHang INT FOREIGN KEY REFERENCES HangThanhVien(MaHang),
    HoTen NVARCHAR(100),
    SoDienThoai VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100),
    TongDiemTichLuy INT DEFAULT 0,
    NgayTao DATETIME DEFAULT GETDATE()
);

CREATE TABLE ViKhachHang (
    MaVi INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT FOREIGN KEY REFERENCES KhachHang(MaKhachHang),
    SoDu DECIMAL(18,2) DEFAULT 0,
    CapNhatLanCuoi DATETIME DEFAULT GETDATE()
);

CREATE TABLE DanhSachDen (
    MaDSDen INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT FOREIGN KEY REFERENCES KhachHang(MaKhachHang),
    LyDo NVARCHAR(MAX),
    BiCamDenNgay DATE
);

-----------------------------------------------------------
-- NHÓM 4: VÉ & KIỂM SOÁT (7 BẢNG)
-----------------------------------------------------------
CREATE TABLE GiaVeTranDau (
    MaGiaVe INT PRIMARY KEY IDENTITY(1,1),
    MaTranDau INT FOREIGN KEY REFERENCES TranDau(MaTranDau),
    MaPhanKhu INT FOREIGN KEY REFERENCES PhanKhu(MaPhanKhu),
    MaLoaiGhe INT FOREIGN KEY REFERENCES LoaiGhe(MaLoaiGhe),
    GiaVe DECIMAL(18,2) NOT NULL
);

CREATE TABLE GiuChoTamThoi (
    MaGiuCho INT PRIMARY KEY IDENTITY(1,1),
    MaGhe INT FOREIGN KEY REFERENCES GheNgoi(MaGhe),
    MaTranDau INT FOREIGN KEY REFERENCES TranDau(MaTranDau),
    MaKhachHang INT FOREIGN KEY REFERENCES KhachHang(MaKhachHang),
    ThoiDiemGiu DATETIME DEFAULT GETDATE(),
    ThoiDiemHetHan DATETIME,
    DaXacNhan BIT DEFAULT 0
);

CREATE TABLE ChinhSachHoanTien (
    MaChinhSach INT PRIMARY KEY IDENTITY(1,1),
    MaTranDau INT FOREIGN KEY REFERENCES TranDau(MaTranDau),
    SoGioTruocTran INT,
    PhanTramHoanTien INT,
    DangHieuLuc BIT DEFAULT 1
);

CREATE TABLE KhuyenMai (
    MaKhuyenMai INT PRIMARY KEY IDENTITY(1,1),
    MaCodeKhuyenMai VARCHAR(20) UNIQUE NOT NULL,
    MoTa NVARCHAR(255),
    SoTienGiam DECIMAL(18,2),
    PhanTramGiam INT,
    NgayBatDau DATETIME,
    NgayKetThuc DATETIME,
    GioiHanLuotDung INT,
    DaDung INT DEFAULT 0
);

CREATE TABLE Ve (
    MaVe INT PRIMARY KEY IDENTITY(1,1),
    MaTranDau INT FOREIGN KEY REFERENCES TranDau(MaTranDau),
    MaGhe INT FOREIGN KEY REFERENCES GheNgoi(MaGhe),
    MaKhachHang INT FOREIGN KEY REFERENCES KhachHang(MaKhachHang),
    MaKhuyenMai INT FOREIGN KEY REFERENCES KhuyenMai(MaKhuyenMai),
    ThoiGianDat DATETIME DEFAULT GETDATE(),
    GiaCuoiCung DECIMAL(18,2),
    TienThue DECIMAL(18,2),
    MaCodeVe VARCHAR(100) UNIQUE,
    TrangThai NVARCHAR(20)
);

CREATE TABLE NguoiSuDungVe (
    MaNguoiDung INT PRIMARY KEY IDENTITY(1,1),
    MaVe INT FOREIGN KEY REFERENCES Ve(MaVe),
    HoTenNguoiDung NVARCHAR(100),
    CMND_CCCD VARCHAR(20)
);

CREATE TABLE NhatKyVaoCong (
    MaNhatKy INT PRIMARY KEY IDENTITY(1,1),
    MaVe INT FOREIGN KEY REFERENCES Ve(MaVe),
    MaCong INT FOREIGN KEY REFERENCES CongRaVao(MaCong),
    ThoiGianVao DATETIME DEFAULT GETDATE()
);

-----------------------------------------------------------
-- NHÓM 5: DỊCH VỤ & BÁN HÀNG (5 BẢNG)
-----------------------------------------------------------
CREATE TABLE DanhMucSanPham (
    MaDanhMuc INT PRIMARY KEY IDENTITY(1,1),
    TenDanhMuc NVARCHAR(50)
);

CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY IDENTITY(1,1),
    MaDanhMuc INT FOREIGN KEY REFERENCES DanhMucSanPham(MaDanhMuc),
    TenSanPham NVARCHAR(100),
    GiaBan DECIMAL(18,2),
    SoLuongTon INT
);

CREATE TABLE GoiCombo (
    MaCombo INT PRIMARY KEY IDENTITY(1,1),
    TenCombo NVARCHAR(100),
    GiaGoc DECIMAL(18,2),
    GiaKhuyenMai DECIMAL(18,2),
    NgayBatDau DATETIME,
    NgayKetThuc DATETIME
);

CREATE TABLE ChiTietCombo (
    MaChiTietCombo INT PRIMARY KEY IDENTITY(1,1),
    MaCombo INT FOREIGN KEY REFERENCES GoiCombo(MaCombo),
    MaSanPham INT FOREIGN KEY REFERENCES SanPham(MaSanPham),
    SoLuong INT
);

CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT FOREIGN KEY REFERENCES KhachHang(MaKhachHang),
    TongTien DECIMAL(18,2) NOT NULL,
    TienThue DECIMAL(18,2) DEFAULT 0,
    NgayTao DATETIME DEFAULT GETDATE()
);

-----------------------------------------------------------
-- NHÓM 6: CHI TIẾT GIAO DỊCH (2 BẢNG)
-----------------------------------------------------------
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT FOREIGN KEY REFERENCES DonHang(MaDonHang),
    MaSanPham INT FOREIGN KEY REFERENCES SanPham(MaSanPham),
    MaCombo INT NULL FOREIGN KEY REFERENCES GoiCombo(MaCombo),
    SoLuong INT,
    DonGia DECIMAL(18,2)
);

CREATE TABLE GiaoDich (
    MaGiaoDich INT PRIMARY KEY IDENTITY(1,1),
    MaVe INT NULL FOREIGN KEY REFERENCES Ve(MaVe),
    MaDonHang INT NULL FOREIGN KEY REFERENCES DonHang(MaDonHang),
    MaVi INT NULL FOREIGN KEY REFERENCES ViKhachHang(MaVi),
    SoTien DECIMAL(18,2) NOT NULL,
    PhiDichVu DECIMAL(18,2) DEFAULT 0,
    LoaiGiaoDich NVARCHAR(50),
    TrangThai NVARCHAR(50),
    NgayTao DATETIME DEFAULT GETDATE()
);

-----------------------------------------------------------
-- NHÓM 7: NHÂN SỰ & VẬN HÀNH (5 BẢNG)
-----------------------------------------------------------
CREATE TABLE VaiTro (
    MaVaiTro INT PRIMARY KEY IDENTITY(1,1),
    TenVaiTro NVARCHAR(50)
);

CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY IDENTITY(1,1),
    MaVaiTro INT FOREIGN KEY REFERENCES VaiTro(MaVaiTro),
    HoTen NVARCHAR(100),
    TenDangNhap VARCHAR(50) UNIQUE,
    MatKhauHash VARCHAR(MAX)
);

CREATE TABLE PhanCongCongViec (
    MaPhanCong INT PRIMARY KEY IDENTITY(1,1),
    MaNhanVien INT FOREIGN KEY REFERENCES NhanVien(MaNhanVien),
    MaTranDau INT FOREIGN KEY REFERENCES TranDau(MaTranDau),
    MaCong INT NULL FOREIGN KEY REFERENCES CongRaVao(MaCong),
    MoTaNhiemVu NVARCHAR(255)
);

CREATE TABLE TaiSanSan (
    MaTaiSan INT PRIMARY KEY IDENTITY(1,1),
    TenTaiSan NVARCHAR(100),
    TrangThai NVARCHAR(50)
);

CREATE TABLE YeuCauBaoTri (
    MaYeuCau INT PRIMARY KEY IDENTITY(1,1),
    MaTaiSan INT NULL FOREIGN KEY REFERENCES TaiSanSan(MaTaiSan),
    MaGhe INT NULL FOREIGN KEY REFERENCES GheNgoi(MaGhe),
    MaNhanVien INT FOREIGN KEY REFERENCES NhanVien(MaNhanVien),
    MoTaLoi NVARCHAR(MAX),
    TrangThaiYeuCau NVARCHAR(20) DEFAULT 'ChoXuLy',
    NgayTao DATETIME DEFAULT GETDATE()
);

-----------------------------------------------------------
-- NHÓM 8: MARKETING, LOGS & CẤU HÌNH (7 BẢNG)
-----------------------------------------------------------
CREATE TABLE CauHinhHeThong (
    KhoaCauHinh VARCHAR(50) PRIMARY KEY,
    GiaTriCauHinh NVARCHAR(100)
);

CREATE TABLE ThongBao (
    MaThongBao INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT FOREIGN KEY REFERENCES KhachHang(MaKhachHang),
    TieuDe NVARCHAR(200),
    NoiDung NVARCHAR(MAX),
    DaDoc BIT DEFAULT 0,
    NgayTao DATETIME DEFAULT GETDATE()
);

CREATE TABLE NhatKyThayDoiGia (
    MaNhatKy INT PRIMARY KEY IDENTITY(1,1),
    MaGiaVe INT FOREIGN KEY REFERENCES GiaVeTranDau(MaGiaVe),
    GiaCu DECIMAL(18,2),
    GiaMoi DECIMAL(18,2),
    NguoiThayDoi INT FOREIGN KEY REFERENCES NhanVien(MaNhanVien),
    NgayThayDoi DATETIME DEFAULT GETDATE()
);

CREATE TABLE NhatKyThietBiVe (
    MaNhatKyThietBi INT PRIMARY KEY IDENTITY(1,1),
    MaVe INT FOREIGN KEY REFERENCES Ve(MaVe),
    MaThietBi VARCHAR(100),
    ThoiGianXacThuc DATETIME DEFAULT GETDATE()
);

CREATE TABLE NhatKyHeThong (
    MaNhatKyHeThong INT PRIMARY KEY IDENTITY(1,1),
    MaNhanVien INT FOREIGN KEY REFERENCES NhanVien(MaNhanVien),
    MoTaHanhDong NVARCHAR(MAX),
    ThoiGianHanhDong DATETIME DEFAULT GETDATE()
);

CREATE TABLE CauHinhPhi (
    MaPhi INT PRIMARY KEY IDENTITY(1,1),
    TenPhi NVARCHAR(100),
    MucPhi DECIMAL(18,2),
    LaPhanTram BIT
);

CREATE TABLE QuyDinhVaoCong (
    MaQuyDinh INT PRIMARY KEY IDENTITY(1,1),
    MaCong INT FOREIGN KEY REFERENCES CongRaVao(MaCong),
    MaPhanKhu INT FOREIGN KEY REFERENCES PhanKhu(MaPhanKhu),
    LaCongChinh BIT DEFAULT 1
);

-----------------------------------------------------------
-- RÀNG BUỘC & CHỈ MỤC (TỐI ƯU)
-----------------------------------------------------------
CREATE UNIQUE INDEX UIX_TranDau_GheNgoi_DuyNhat 
ON Ve (MaTranDau, MaGhe) 
WHERE TrangThai IN ('HopLe', 'DaSuDung');

CREATE INDEX IX_TranDau_ThoiGian ON TranDau (ThoiGianBatDau);
CREATE INDEX IX_GiaoDich_NgayTao ON GiaoDich (NgayTao);
GO