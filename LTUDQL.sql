﻿use master
go
if db_id('ltudql1') is not null
	drop database ltudql1
go 
create database ltudql1
go
use ltudql1
go

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'UserNameDisplayName',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff
)
create table LoaiKH
(
ID_Loai int,
TenLoai nvarchar(500)
primary key(ID_Loai)
)
create table LoaiXe
(
ID_LoaiXe int,
TenLoai nvarchar(4000),
primary key(ID_LoaiXe)
)
create table Xe
(
XeID int,
TenXe nvarchar(4000),
So_dang_ky varchar(4000),
LoaiXe_ID_LoaiXe int,
primary key(XeID),
foreign key(LoaiXe_ID_LoaiXe) references LoaiXe
)


create table KhachHang
(
ID_KhachHang int,
HoTen nvarchar(4000),
DienThoai varchar(4000),
Email varchar(4000),
Loai int,
primary key(ID_KhachHang),
foreign key(Loai) references LoaiKH ON DELETE CASCADE
)
create table Tai_xe
(
ID_TaiXe int,
TenTaiXe nvarchar(4000),
BangLai nvarchar(4000),
primary key (ID_TaiXe)
)

create table Tram
(
ID_Tram int,
TenTram nvarchar(4000),
Dia_diem nvarchar(4000),
primary key(ID_Tram)
)
create table Tuyen
(
ID_Tuyen int,
KhoangCach int,
TenTuyen nvarchar(100),
ThoiGianChay int,
Tram_ID_Tram1 int,
Tram_ID_Tram int,
primary key(ID_Tuyen),
foreign key(Tram_ID_Tram) references Tram,
foreign key(Tram_ID_Tram1) references Tram
)
create table Tram_trung_gian
(
Tuyen_ID_Tuyen int,
Tram_ID_Tram int,
Thu_tu int,
primary key(Tuyen_ID_Tuyen,Tram_ID_Tram),
foreign key(Tram_ID_Tram) references Tram
ON DELETE CASCADE ,
foreign key(Tuyen_ID_Tuyen) references Tuyen
ON DELETE CASCADE 
)


create table Ghe
( 
ID_Ghe int,
Dong int,
CCot int,
Tang int,
So_ghe int,
Xe_XeID int,

primary key(ID_Ghe),
foreign key(Xe_XeID) references Xe
ON DELETE CASCADE 
)
create table Chuyen
(
ID_Chuyen int,
Tuyen_ID_Tuyen int,
Gio_khoi_hanh datetime,
Ghi_chu nvarchar(4000),
Xe_XeID int,
Tai_xe_ID_Taixe int,
primary key(ID_Chuyen),
foreign key(Tai_xe_ID_Taixe) references Tai_xe,
foreign key(Tuyen_ID_Tuyen) references Tuyen,
foreign key(Xe_XeID) references Xe
)

create table Ve
(
ID_Ve int,
Ghe_ID_Ghe int,
Chuyen_ID_Chuyen int,
TinhTrang int,
GiaTien int,
KhachHang_ID_KhachHang int,
NgayXuatVe date,
GhiChu nvarchar(4000)
primary key(ID_Ve),
foreign key(Chuyen_ID_Chuyen) references Chuyen ON DELETE CASCADE ,
foreign key(KhachHang_ID_KhachHang) references KhachHang ON DELETE CASCADE 
)

go
--------Insert Dữ liệu----------
INSERT INTO Account(UserName,PassWord,DisplayName,Type) VALUES (N'Admin',N'123',N'Admin',1)
INSERT INTO LoaiKH(ID_Loai,TenLoai) VALUES (1,N'Khách hàng thường')
INSERT INTO LoaiKH(ID_Loai,TenLoai) VALUES (2,N'Khách hàng thân thiết')
INSERT INTO LoaiXe(ID_LoaiXe,TenLoai)VALUES  ( 1, N'30 Chỗ')
INSERT INTO LoaiXe(ID_LoaiXe,TenLoai)VALUES  ( 2, N'45 Chỗ')
INSERT INTO LoaiXe(ID_LoaiXe,TenLoai)VALUES  ( 3, N'Giường nằm')
INSERT INTO Tram(ID_Tram,TenTram,Dia_diem)VALUES  ( 1, N'Bến xe Sài Gòn',N'Sài Gòn')
INSERT INTO Tram(ID_Tram,TenTram,Dia_diem)VALUES  ( 2, N'Bến xe Đồng Nai',N'Đồng Nai')
INSERT INTO Tram(ID_Tram,TenTram,Dia_diem)VALUES  ( 3, N'Bến xe Vũng Tàu',N'Vũng Tàu')
INSERT INTO Tram(ID_Tram,TenTram,Dia_diem)VALUES  ( 4, N'Bến xe Đà Nẵng',N'Đà Nẵng')
INSERT INTO Tram(ID_Tram,TenTram,Dia_diem)VALUES  ( 5, N'Bến xe Hà Nội',N'Hà Nội')
INSERT INTO Chuyen (ID_Chuyen ,Tuyen_ID_Tuyen ,Gio_khoi_hanh ,Ghi_chu ,Xe_XeID ,Tai_xe_ID_Taixe ) 
VALUES
('1', '1', '2019-01-21 08:00:00', N'Xe còn tốt', '2','1'), 
('2', '3', '2019-01-26 05:30:00', N'Xe còn tốt', '1','3'); 
INSERT INTO Ghe(ID_Ghe,Dong,CCot,Tang,So_ghe,Xe_XeID)
VALUES
('1','2','3','1','25','1');
INSERT INTO KhachHang(ID_KhachHang,HoTen,DienThoai,Email,Loai)
VALUES
('1',N'Phan Quốc Việt','0366666555','viet@gmail','1');

INSERT INTO Tai_xe(ID_TaiXe,TenTaiXe,BangLai)
VALUES
('1',N'Đinh Thế Hiền Vương',N'Hang A,B,C'),
('2',N'Phạm Quốc Việt Nam',N'Hạng A,B,C'),
('3',N'Nguyễn Văn Chí',N'Hạng A,B,C'),
('4',N'Hồ Văn Vương',N'Hạng A,B,C,D');

INSERT INTO Tram_trung_gian(Tuyen_ID_Tuyen,Tram_ID_Tram,Thu_tu)
VALUES
('1','2','10'),
('2','1','10');
INSERT INTO Tuyen(ID_Tuyen,KhoangCach,TenTuyen,ThoiGianChay,Tram_ID_Tram1,Tram_ID_Tram)
VALUES
('1','200',N'TPHCM-Vũng Tàu','3','2','1');
INSERT INTO Ve(ID_Ve,Ghe_ID_Ghe,Chuyen_ID_Chuyen,TinhTrang,GiaTien,KhachHang_ID_KhachHang,NgayXuatVe,GhiChu)
VALUES
('1','1','1','0','250000','2','2019-01-21 08:00:00',N'Đã hết');
INSERT INTO Xe(XeID,TenXe,So_dang_ky,LoaiXe_ID_LoaiXe)
VALUES
('1','yamaha','25A54VV','2');


go
--------Store Procedure---------

--Proc kiểm tra người mua vé có tên tàii trong CSDL hay ko
CREATE PROCEDURE sp_KiemTraKH @hoten nvarchar(500)
AS
BEGIN
	SELECT * FROM KhachHang WHERE @hoten like HoTen
END
GO

CREATE PROCEDURE sp_ThemKH @hoten nvarchar(500),@sdt varchar(11),@email varchar(50),@loai varchar(50)
AS
BEGIN
	DECLARE @id int
	IF NOT EXISTS(SELECT * FROM KhachHang)
	begin
		SET @id=0
	end
	ELSE
	begin
		SELECT @id=MAX(ID_KhachHang) FROM KhachHang
	end
	IF NOT EXISTS(SELECT * FROM KhachHang WHERE DienThoai=@sdt or Email=@email)
		INSERT INTO KhachHang ( ID_KhachHang, HoTen, DienThoai, Email, Loai )VALUES  ( @id+1, @hoten, @sdt, @email, @loai)
END

GO
CREATE PROCEDURE sp_SuaKH @id int,@hoten nvarchar(500),@sdt varchar(11),@email varchar(50),@loai varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM KhachHang WHERE ID_KhachHang!=@id and (DienThoai=@sdt or Email=@email))
		UPDATE KhachHang SET HoTen = @hoten, DienThoai = @sdt, Email=@email,Loai=@loai WHERE @id = ID_KhachHang
END
go

CREATE PROCEDURE sp_ThemTuyenXe @kc int,@tg int , @id_tramdau int, @id_tramcuoi int
AS
BEGIN
	DECLARE @id int, @tendau nvarchar(50), @tencuoi nvarchar(50),@ten nvarchar(50)
	IF NOT EXISTS(SELECT * FROM Tuyen)
	begin
		SET @id=0
	end
	ELSE
	begin
		SELECT @id=MAX(ID_Tuyen) FROM Tuyen
	end
	SELECT @tendau=Dia_diem FROM Tram WHERE ID_Tram = @id_tramdau
	SELECT @tencuoi=Dia_diem FROM Tram WHERE ID_Tram = @id_tramcuoi

	SELECT @ten = @tendau + ' - ' + @tencuoi
	INSERT INTO Tuyen( ID_Tuyen, KhoangCach, ThoiGianChay, Tram_ID_Tram, Tram_ID_Tram1,TenTuyen )VALUES  ( @id+1, @kc,@tg,@id_tramdau,@id_tramcuoi,@ten)
END
go

CREATE PROCEDURE sp_SuaTuyenXe @id int,@kc int,@tg int , @id_tramdau int, @id_tramcuoi int
AS
BEGIN
	DECLARE @tendau nvarchar(50), @tencuoi nvarchar(50),@ten nvarchar(100)
	SELECT @tendau=Dia_diem FROM Tram WHERE ID_Tram = @id_tramdau
	SELECT @tencuoi=Dia_diem FROM Tram WHERE ID_Tram = @id_tramcuoi

	SELECT @ten = @tendau + ' - ' + @tencuoi
	UPDATE Tuyen SET KhoangCach = @kc, ThoiGianChay = @tg, Tram_ID_Tram=@id_tramdau,Tram_ID_Tram1=@id_tramcuoi,TenTuyen=@ten WHERE @id = ID_Tuyen
END
go

CREATE PROCEDURE sp_XoaTuyenXe @id int
AS
BEGIN
	DELETE Tuyen WHERE ID_Tuyen=@id
END
go

CREATE PROCEDURE sp_ThemTramTG @idtuyen int, @idtram int
AS
BEGIN
	DECLARE @stt int
	IF NOT EXISTS(SELECT * FROM Tram_trung_gian)
	begin
		SET @stt=0
	end
	ELSE
	begin
		SELECT @stt=MAX(Thu_tu) FROM Tram_trung_gian
	end
	INSERT INTO Tram_trung_gian( Thu_tu,Tuyen_ID_Tuyen,Tram_ID_Tram)VALUES  ( @stt+1,@idtuyen,@idtram)
END
go

CREATE PROCEDURE sp_ThemChuyenXe @idtuyen int, @giokh DATETIME, @idtaixe int, @idxe int, @ghichu nvarchar(500)
AS
BEGIN
	DECLARE @id int
	IF NOT EXISTS(SELECT * FROM Chuyen)
	begin
		SET @id=0
	end
	ELSE
	begin
		SELECT @id=MAX(ID_Chuyen) FROM Chuyen
	end
	INSERT INTO Chuyen(ID_Chuyen,Tuyen_ID_Tuyen,Gio_khoi_hanh,Tai_xe_ID_Taixe,Ghi_chu,Xe_XeID )VALUES  (@id+1 ,@idtuyen,@giokh,@idtaixe,@ghichu,@idxe )
END


go

CREATE PROCEDURE sp_CreateGhe @id_xe int, @dong int, @cot int, @tang int, @soghe int
AS
BEGIN
	DECLARE @id int
	IF NOT EXISTS(SELECT * FROM Ghe)
	begin
		SET @id=0
	end
	ELSE
	begin
		SELECT @id=MAX(ID_Ghe) FROM Ghe
	end
	INSERT INTO Ghe( ID_Ghe,Dong,Ghe.CCot,Tang,So_ghe,Xe_XeID )VALUES  ( @id+1,@dong,@cot,@tang,@soghe,@id_xe)
END
go

CREATE PROCEDURE sp_Xe @ten nvarchar(50),@sodk nvarchar(50), @loaixe int
AS
BEGIN
	DECLARE @id int
	IF NOT EXISTS(SELECT * FROM Xe)
	begin
		SET @id=0
	end
	ELSE
	begin
		SELECT @id=MAX(XeID) FROM Xe
	end
	INSERT INTO Xe( XeID,TenXe,So_dang_ky,LoaiXe_ID_LoaiXe )VALUES  ( @id+1,@ten,@sodk,@loaixe)
	set @id=@id+1
	IF(@loaixe=1)
	begin
		Declare @i int,@c int,@d int
		set @i=1 set @c=1 set @d=1
		while(@i<=30)
		begin
			EXEC sp_CreateGhe @id,@d,@c,0,@i
			set @i=@i+1 set @c=@c+1
			if((@c>4)or(@d = 4 and @c>2))
			begin
				Set @c=1 set @d = @d+1
			end
		end
	end
	IF(@loaixe=2)
	begin
		set @i=1 set @c=1 set @d=1
		while(@i<=45)
		begin
			EXEC sp_CreateGhe @id,@d,@c,0,@i
			set @i=@i+1 
			if(@i>41)
			begin
				Set @c=@c+1
			end
			if(@c>4 and @i<=41)
			begin
			set @c=@c+1
				Set @c=1 set @d = @d+1
			end
			
		end
	end
	IF(@loaixe=3)
	begin
		declare @tang int
		set @tang=1
		set @i=1 set @c=1 set @d=1
		while(@i<=46)
		begin
			EXEC sp_CreateGhe @id,@d,@c,@tang,@i
			if(@i=23)
			Begin
				set @c=1 set @d=1 set @tang=2
				set @i=@i+1
			End
			Else
			Begin
				set @i=@i+1 
				if(@i>20)
				begin
					Set @c=@c+1
				end
				if(@c>3 and @i<=20)
				begin
					set @c=@c+1
					Set @c=1 set @d = @d+1
				end
			End
		end
	end
END
go
CREATE PROCEDURE sp_ThemTaiXe @ten nvarchar(50),@bang nvarchar(50)
AS
BEGIN
	DECLARE @id int
	IF NOT EXISTS(SELECT * FROM Tai_xe)
	begin
		SET @id=0
	end
	ELSE
	begin
		SELECT @id=MAX(ID_TaiXe) FROM Tai_xe
	end
	INSERT INTO Tai_xe(ID_TaiXe,TenTaiXe,BangLai)VALUES  (@id+1, @ten,@bang)
END
go

CREATE PROCEDURE sp_SearchChuyenTheoTuyen @id_dau int,@id_cuoi int
AS
BEGIN
	SELECT * FROM Chuyen,Tuyen WHERE Chuyen.Tuyen_ID_Tuyen=Tuyen.ID_Tuyen and Tram_ID_Tram=@id_dau and Tram_ID_Tram1=@id_cuoi
END
go

CREATE PROC USP_Login @userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

CREATE PROC USP_GetLoginType @userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT Type FROM Account WHERE UserName = @userName AND PassWord = @passWord
END
GO