DROP TABLE IF EXISTS KhachHang CASCADE;
DROP TABLE IF EXISTS SanPham CASCADE;
DROP TABLE IF EXISTS DonHang CASCADE;
DROP TABLE IF EXISTS ChiTietDonHang CASCADE;

-- ============================================
-- 1. TẠO CÁC BẢNG
-- ============================================

CREATE TABLE KhachHang (
                           maKH        SERIAL PRIMARY KEY,
                           tenKH       VARCHAR(100)  NOT NULL,
                           dienthoai   VARCHAR(15)   UNIQUE NOT NULL,
                           diachi      VARCHAR(255),
                           ngaydangky  DATE          DEFAULT CURRENT_DATE
);

CREATE TABLE SanPham (
                         maSP    SERIAL PRIMARY KEY,
                         tenSP   VARCHAR(150)  NOT NULL,
                         gia     DECIMAL(10,2) NOT NULL CHECK (gia > 0),
                         loaiSP  VARCHAR(50)   NOT NULL
);

CREATE TABLE DonHang (
                         maDH      SERIAL PRIMARY KEY,
                         maKH      INT          NOT NULL,
                         ngaydat   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
                         trangthai VARCHAR(50)  DEFAULT 'Chờ xác nhận',
                         FOREIGN KEY (maKH) REFERENCES KhachHang(maKH)
);

CREATE TABLE ChiTietDonHang (
                                maDH    INT           NOT NULL,
                                maSP    INT           NOT NULL,
                                soluong INT           NOT NULL CHECK (soluong > 0),
                                dongia  DECIMAL(10,2) NOT NULL CHECK (dongia > 0),
                                PRIMARY KEY (maDH, maSP),
                                FOREIGN KEY (maDH) REFERENCES DonHang(maDH),
                                FOREIGN KEY (maSP) REFERENCES SanPham(maSP)
);

-- ============================================
-- 2. THÊM DỮ LIỆU
-- ============================================

-- KhachHang (15 khách hàng)
INSERT INTO KhachHang (tenKH, dienthoai, diachi, ngaydangky) VALUES
                                                                 ('Nguyễn Văn An',     '0901234501', 'Hà Nội',          '2024-01-10'),
                                                                 ('Trần Thị Bình',     '0901234502', 'TP. Hồ Chí Minh', '2024-02-15'),
                                                                 ('Lê Hoàng Cường',    '0901234503', 'Đà Nẵng',         '2024-03-20'),
                                                                 ('Phạm Thị Dung',     '0901234504', 'Hải Phòng',       '2024-04-05'),
                                                                 ('Hoàng Văn Em',      '0901234505', 'Cần Thơ',         '2024-05-12'),
                                                                 ('Vũ Thị Phương',     '0901234506', 'Huế',             '2024-06-18'),
                                                                 ('Đặng Minh Quân',    '0901234507', 'Nha Trang',       '2024-07-22'),
                                                                 ('Bùi Thị Hoa',       '0901234508', 'Vũng Tàu',        '2024-08-30'),
                                                                 ('Ngô Văn Hùng',      '0901234509', 'Bình Dương',      '2024-09-14'),
                                                                 ('Đinh Thị Lan',      '0901234510', 'Đồng Nai',        '2024-10-01'),
                                                                 ('Trịnh Văn Minh',    '0901234511', 'Hà Nội',          '2024-11-05'),
                                                                 ('Lý Thị Ngọc',       '0901234512', 'TP. Hồ Chí Minh', '2024-12-10'),
                                                                 ('Phan Đức Thành',    '0901234513', 'Quảng Ninh',      '2025-01-08'),
                                                                 ('Cao Thị Uyên',      '0901234514', 'Hà Nội',          '2025-02-20'),
                                                                 ('Mai Văn Việt',      '0901234515', 'TP. Hồ Chí Minh', '2025-03-15');

-- SanPham (15 sản phẩm, nhiều loại)
INSERT INTO SanPham (tenSP, gia, loaiSP) VALUES
                                             ('Trà xanh Thái Nguyên',       45000,  'Trà'),
                                             ('Trà ô long Đà Lạt',          65000,  'Trà'),
                                             ('Trà hoa cúc',                35000,  'Trà'),
                                             ('Trà gừng mật ong',           55000,  'Trà'),
                                             ('Cà phê Arabica rang xay',    120000, 'Cà phê'),
                                             ('Cà phê Robusta nguyên chất', 95000,  'Cà phê'),
                                             ('Cà phê hoà tan 3in1',        75000,  'Cà phê'),
                                             ('Áo thun nam basic',          150000, 'Áo'),
                                             ('Áo sơ mi nữ linen',          220000, 'Áo'),
                                             ('Áo khoác hoodie unisex',     350000, 'Áo'),
                                             ('Giày sneaker nam',           650000, 'Giày'),
                                             ('Giày cao gót nữ',            480000, 'Giày'),
                                             ('Dép sandal thể thao',        180000, 'Dép'),
                                             ('Mũ bucket vải',               95000, 'Mũ'),
                                             ('Mũ lưỡi trai thêu',          110000, 'Mũ');

-- DonHang (18 đơn hàng)
INSERT INTO DonHang (maKH, ngaydat, trangthai) VALUES
                                                   (1,  '2026-01-05 09:00:00', 'Hoàn thành'),
                                                   (2,  '2026-01-12 10:30:00', 'Hoàn thành'),
                                                   (3,  '2026-01-20 14:00:00', 'Hoàn thành'),
                                                   (1,  '2026-02-03 08:45:00', 'Hoàn thành'),
                                                   (4,  '2026-02-14 11:00:00', 'Hoàn thành'),
                                                   (5,  '2026-02-25 15:30:00', 'Hoàn thành'),
                                                   (2,  '2026-03-01 09:15:00', 'Hoàn thành'),
                                                   (6,  '2026-03-05 13:00:00', 'Đang giao'),
                                                   (7,  '2026-03-10 10:00:00', 'Đang giao'),
                                                   (3,  '2026-03-15 16:00:00', 'Hoàn thành'),
                                                   (8,  '2026-03-18 09:30:00', 'Đang giao'),
                                                   (9,  '2026-03-20 11:45:00', 'Chờ xác nhận'),
                                                   (10, '2026-03-22 14:20:00', 'Chờ xác nhận'),
                                                   (1,  '2026-03-25 08:00:00', 'Chờ xác nhận'),
                                                   (11, '2026-04-01 10:00:00', 'Chờ xác nhận'),
                                                   (12, '2026-04-05 13:30:00', 'Chờ xác nhận'),
                                                   (5,  '2026-04-08 09:00:00', 'Chờ xác nhận'),
                                                   (13, '2026-04-10 15:00:00', 'Chờ xác nhận');

-- ChiTietDonHang (~42 dòng)
INSERT INTO ChiTietDonHang (maDH, maSP, soluong, dongia) VALUES
-- Đơn 1: Áo + Mũ
(1,  8,  2, 150000),
(1,  14, 1,  95000),
-- Đơn 2: Trà + Cà phê
(2,  1,  3,  45000),
(2,  5,  1, 120000),
-- Đơn 3: Giày + Dép
(3,  11, 1, 650000),
(3,  13, 2, 180000),
-- Đơn 4: Trà các loại
(4,  1,  2,  45000),
(4,  2,  1,  65000),
(4,  3,  2,  35000),
-- Đơn 5: Áo + Giày
(5,  9,  1, 220000),
(5,  12, 1, 480000),
-- Đơn 6: Cà phê
(6,  5,  2, 120000),
(6,  6,  2,  95000),
(6,  7,  3,  75000),
-- Đơn 7: Trà + Áo
(7,  4,  2,  55000),
(7,  10, 1, 350000),
-- Đơn 8: Mũ + Dép
(8,  14, 2,  95000),
(8,  15, 1, 110000),
(8,  13, 1, 180000),
-- Đơn 9: Giày + Áo
(9,  11, 1, 650000),
(9,  8,  3, 150000),
-- Đơn 10: Trà
(10, 2,  2,  65000),
(10, 3,  3,  35000),
(10, 4,  1,  55000),
-- Đơn 11: Cà phê + Trà
(11, 5,  1, 120000),
(11, 1,  2,  45000),
-- Đơn 12: Áo + Mũ
(12, 9,  2, 220000),
(12, 10, 1, 350000),
(12, 15, 1, 110000),
-- Đơn 13: Dép + Giày
(13, 13, 2, 180000),
(13, 12, 1, 480000),
-- Đơn 14: Trà + Cà phê
(14, 1,  1,  45000),
(14, 2,  1,  65000),
(14, 6,  2,  95000),
-- Đơn 15: Áo
(15, 8,  2, 150000),
(15, 9,  1, 220000),
-- Đơn 16: Mũ + Dép
(16, 14, 3,  95000),
(16, 13, 2, 180000),
-- Đơn 17: Cà phê
(17, 5,  2, 120000),
(17, 7,  3,  75000),
-- Đơn 18: Trà + Giày
(18, 3,  2,  35000),
(18, 4,  1,  55000),
(18, 11, 1, 650000);

-- ============================================
-- KIỂM TRA DỮ LIỆU
-- ============================================
SELECT 'KhachHang'      AS bang, COUNT(*) AS so_ban_ghi FROM KhachHang
UNION ALL
SELECT 'SanPham',                COUNT(*) FROM SanPham
UNION ALL
SELECT 'DonHang',                COUNT(*) FROM DonHang
UNION ALL
SELECT 'ChiTietDonHang',         COUNT(*) FROM ChiTietDonHang;