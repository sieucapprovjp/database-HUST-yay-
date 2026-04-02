DROP TABLE IF EXISTS registration CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS student CASCADE;

CREATE TABLE student(
    sid INT PRIMARY KEY,
    name varchar(20) NOT NULL,
    address varchar(50),
    city varchar(20) NOT NULL,
    dob DATE NOT NULL,
    gender varchar(10));

CREATE TABLE course(
    cid varchar(8) PRIMARY KEY,
    name varchar(100) NOT NULL,
    credit INT NOT NULL,
    final_weight DECIMAL(3,2) NOT NULL CHECK (final_weight BETWEEN 0.1 AND 1));

CREATE TABLE registration(
    sid INT NOT NULL,
    cid varchar(8) NOT NULL ,
    semester varchar(5),
    midterm INT NOT NULL CHECK (midterm BETWEEN 0.1 AND 10),
    finalterm INT NOT NULL CHECK (finalterm BETWEEN 0.1 AND 10),
    CONSTRAINT FK_sid FOREIGN KEY (sid) REFERENCES student(sid)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE,
    CONSTRAINT FK_cid FOREIGN KEY (cid) REFERENCES course(cid)
                         ON DELETE CASCADE
                         ON UPDATE CASCADE,
    PRIMARY KEY(sid,cid,semester)
);

INSERT INTO student(sid, name,address,city,dob,gender) VALUES
('202410001', 'Nguyễn Văn An', 'Cầu Giấy', 'Hà Nội', '2006-05-10', 'M'),
('202410002', 'Trần Thị Bình', 'Lê Duẩn', 'TP.HCM', '2006-08-22', 'F'),
('202410003', 'Lê Văn Cường', 'Trần Phú', 'Đà Nẵng', '2006-12-01', 'M'),
('202410004', 'Phạm Thị Dung', 'Lê Lợi', 'Hải Phòng', '2006-03-15', 'F'),
('202410005', 'Hoàng Văn Em', 'Bạch Mai', 'Hà Nội', '2006-07-30', 'M'),
('202410006', 'Ngô Thị Phương', 'Đông Anh', 'Hà Nội', '2006-11-05', 'F'),
('202410007', 'Vũ Văn Giang', '90 Phan Chu Trinh', 'Thái Nguyên', '2006-09-18', 'M'),
('202410008', 'Đặng Thị Hoa', 'Phố Hiến', 'Hưng Yên', '2006-01-25', 'F'),
('202410009', 'Bùi Văn Inh', 'Đống Đa', 'Hà Nội', '2006-06-14', 'M'),
('202410010', 'Đinh Thị Kim', 'Tân Hưng', 'Hưng Yên', '2006-04-08', 'F');

INSERT INTO course (cid, name, credit, final_weight) VALUES
('PE2501', 'Cầu Lông 1', 2, 0.5),
('IT3292', 'Cơ sở dữ liệu', 2, 0.6),
('IT3290', 'Thực hành Cơ sở dữ liệu', 2, 0.6),
('IT3160', 'Nhập môn Trí tuệ nhân tạo', 3, 0.7),
('IT2030', 'Technical Writing and Presentation', 3, 0.6),
('MI1134', 'Phương trình vi phân và chuỗi', 2, 0.6),
('PE2151', 'Erobic', 2, 0.5),
('IT3283', 'Kiến trúc máy tính', 4, 0.6),
('IT3230', 'Lập trình C cơ bản', 4, 0.6),
('IT4110', 'Tính toán khoa học', 3, 0.5);

INSERT INTO registration (sid, cid, semester, midterm, finalterm) VALUES
(202410001, 'IT3292', '20231', 1.0, 1.0),
(202410002, 'IT3290', '20231', 7.5, 8.5),
(202410003, 'IT3160', '20231', 6.0, 7.0),
(202410004, 'IT2030', '20232', 9.0, 8.0),
(202410001, 'IT3292', '20232', 5.5, 6.5),
(202410006, 'PE2501', '20231', 10.0, 10.0),
(202410007, 'IT3283', '20232', 7.0, 7.5),
(202410008, 'IT3230', '20232', 8.5, 9.0),
(202410009, 'IT4110', '20231', 4.0, 5.0),
(202410010, 'PE2151', '20231', 9.0, 9.5);