DROP TABLE IF EXISTS KhachHang CASCADE;
DROP TABLE IF EXISTS NhaChoThue CASCADE;
DROP TABLE IF EXISTS HopDong CASCADE;
DROP TABLE IF EXISTS Khach CASCADE;
DROP TABLE IF EXISTS KhachSan CASCADE;
DROP TABLE IF EXISTS Phong CASCADE;
DROP TABLE IF EXISTS DatPhong CASCADE;

-- Tạo bảng Khách hàng
CREATE TABLE KhachHang (
    MaKH VARCHAR(20) PRIMARY KEY,
    Hoten VARCHAR(100),
    Sodienthoai VARCHAR(15),
    Coquan VARCHAR(100)
);

CREATE TABLE NhaChoThue (
    MaN VARCHAR(20) PRIMARY KEY,
    Diachi TEXT, -- Có thể dùng TEXT cho địa chỉ để không giới hạn độ dài
    Giathue NUMERIC(18, 2), -- PostgreSQL thường dùng NUMERIC tương đương với DECIMAL
    Tenchunha VARCHAR(100)
);

-- Tạo bảng Hợp đồng
CREATE TABLE Hopdong (
    MaN VARCHAR(20),
    MaKH VARCHAR(20),
    Ngaybatdau DATE,
    Ngayketthuc DATE,
    PRIMARY KEY (MaN, MaKH, Ngaybatdau),
    FOREIGN KEY (MaN) REFERENCES NhaChoThue(MaN)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE
);

-- 1. Thêm dữ liệu vào bảng Khachhang
INSERT INTO KhachHang (MaKH, Hoten, Sodienthoai, Coquan) VALUES
('KH01', 'Nguyễn Văn A', '0901234567', 'Công ty phần mềm FPT'),
('KH02', 'Trần Thị B', '0912345678', 'Bệnh viện Chợ Rẫy'),
('KH03', 'Lê Văn C', '0923456789', 'Đại học Quốc gia'),
('KH04', 'Phạm Thị D', '0934567890', 'Ngân hàng Vietcombank');

-- 2. Thêm dữ liệu vào bảng Nhachothue
INSERT INTO NhaChoThue (MaN, Diachi, Giathue, Tenchunha) VALUES
('N01', '123 Lê Lợi, Quận 1, TP.HCM', 8.5, 'Nông Văn Dền'), -- Giá < 10, của Nông Văn Dền
('N02', '456 Hai Bà Trưng, Quận 3, TP.HCM', 12.0, 'Trần Văn E'),
('N03', '789 Nguyễn Đình Chiểu, Quận 3, TP.HCM', 15.0, 'Nông Văn Dền'), -- Của Nông Văn Dền
('N04', '101 Mai Thị Lựu, Quận 1, TP.HCM', 9.0, 'Lê Thị F'), -- Giá < 10, CHƯA ai thuê
('N05', '202 Điện Biên Phủ, Bình Thạnh, TP.HCM', 25.0, 'Phạm Văn G'); -- Giá cao nhất

-- 3. Thêm dữ liệu vào bảng Hopdong
INSERT INTO Hopdong (MaN, MaKH, Ngaybatdau, Ngayketthuc) VALUES
('N01', 'KH01', '2023-01-01', '2023-12-31'), -- KH01 thuê nhà N01 của Nông Văn Dền
('N02', 'KH02', '2023-05-01', '2024-05-01'), -- KH02 thuê nhà N02
('N03', 'KH03', '2023-06-01', '2024-06-01'), -- KH03 thuê nhà N03 của Nông Văn Dền
('N05', 'KH01', '2024-01-01', '2025-01-01'); -- KH01 tiếp tục thuê nhà N05 (giá cao nhất)


-- 1. Tạo bảng Khách
CREATE TABLE Khach (
    MaKhach VARCHAR(20) PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    DiaChi TEXT
);

-- 2. Tạo bảng Khách Sạn
CREATE TABLE KhachSan (
    MaKS VARCHAR(20) PRIMARY KEY,
    TenKS VARCHAR(100) NOT NULL,
    DiaChi TEXT
);

-- 3. Tạo bảng Phòng
CREATE TABLE Phong (
    SoP VARCHAR(10),
    MaKS VARCHAR(20),
    LoaiP VARCHAR(50),
    Gia NUMERIC(18, 2),
    PRIMARY KEY (SoP, MaKS),
    FOREIGN KEY (MaKS) REFERENCES KhachSan(MaKS) ON DELETE CASCADE
);

-- 4. Tạo bảng Đặt Phòng
CREATE TABLE DatPhong (
    MaKS VARCHAR(20),
    MaKhach VARCHAR(20),
    NgayNhan DATE,
    NgayTra DATE,
    SoP VARCHAR(10),
    PRIMARY KEY (MaKS, MaKhach, NgayNhan, SoP),
    FOREIGN KEY (SoP, MaKS) REFERENCES Phong(SoP, MaKS) ON DELETE CASCADE,
    FOREIGN KEY (MaKhach) REFERENCES Khach(MaKhach) ON DELETE CASCADE
);