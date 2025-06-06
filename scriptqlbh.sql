﻿USE [master]
GO
/****** Object:  Database [PM_QLBanLinhKien_Laptop]    Script Date: 05/28/2025 10:34:47 PM ******/
CREATE DATABASE [PM_QLBanLinhKien_Laptop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PM_QLBanLinhKien_Laptop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PM_QLBanLinhKien_Laptop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PM_QLBanLinhKien_Laptop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PM_QLBanLinhKien_Laptop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PM_QLBanLinhKien_Laptop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ARITHABORT OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET RECOVERY FULL 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET  MULTI_USER 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET QUERY_STORE = ON
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PM_QLBanLinhKien_Laptop]
GO
/****** Object:  UserDefinedFunction [dbo].[fChuyenCoDauThanhKhongDau]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fChuyenCoDauThanhKhongDau](@inputVar NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END

GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaCV] [nvarchar](50) NOT NULL,
	[TenCV] [nvarchar](50) NOT NULL,
	[NhanVien] [bit] NULL,
	[KhachHang] [bit] NULL,
	[LinhKien] [bit] NULL,
	[BanHang] [bit] NULL,
	[NhaCungCap] [bit] NULL,
	[LoaiLK] [bit] NULL,
	[NhapKho] [bit] NULL,
	[BaoHanh] [bit] NULL,
	[PhanQuyen] [bit] NULL,
	[ThongKe] [bit] NULL,
	[HoaDon] [bit] NULL,
	[Setting] [bit] NULL,
	[TrangThai] [nchar](10) NULL,
	[NhaSanXuat] [bit] NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_HoaDonBanHang]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_HoaDonBanHang](
	[MaHDBH] [nvarchar](50) NOT NULL,
	[MaLK] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [decimal](28, 0) NULL,
	[KhuyenMai] [decimal](28, 0) NULL,
	[ThanhTien] [decimal](28, 0) NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_CT_HoaDonBanHang] PRIMARY KEY CLUSTERED 
(
	[MaHDBH] ASC,
	[MaLK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_HoaDonNhapHang]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_HoaDonNhapHang](
	[MaHDNH] [nvarchar](50) NOT NULL,
	[MaLK] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [decimal](28, 0) NULL,
	[KhuyenMai] [decimal](28, 0) NULL,
	[ThanhTien] [decimal](28, 0) NULL,
	[TrangThai] [nchar](10) NULL,
 CONSTRAINT [PK_CT_HoaDonNhapHang] PRIMARY KEY CLUSTERED 
(
	[MaHDNH] ASC,
	[MaLK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_PhieuBaoHanh]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_PhieuBaoHanh](
	[MaPBH] [nvarchar](50) NOT NULL,
	[TenLK] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GhiChu] [nvarchar](max) NOT NULL,
	[TrangThai] [nvarchar](10) NULL,
 CONSTRAINT [PK_CT_PhieuBaoHanh] PRIMARY KEY CLUSTERED 
(
	[MaPBH] ASC,
	[TenLK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonBanHang]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonBanHang](
	[MaHDBH] [nvarchar](50) NOT NULL,
	[MaKH] [nvarchar](50) NOT NULL,
	[MaNV] [nvarchar](50) NOT NULL,
	[NgayLapHDBH] [datetime] NULL,
	[TongTien] [decimal](28, 0) NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HoaDonBanHang] PRIMARY KEY CLUSTERED 
(
	[MaHDBH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonNhapHang]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonNhapHang](
	[MaHDNH] [nvarchar](50) NOT NULL,
	[MaNCC] [nvarchar](50) NOT NULL,
	[MaNV] [nvarchar](50) NOT NULL,
	[NgayLapHDNH] [datetime] NULL,
	[TongTien] [decimal](28, 0) NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
	[MaNSX] [nvarchar](50) NULL,
 CONSTRAINT [PK_HoaDonNhapHang] PRIMARY KEY CLUSTERED 
(
	[MaHDNH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](50) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[DienThoai] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LinhKien]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LinhKien](
	[MaLK] [nvarchar](50) NOT NULL,
	[MaLLK] [nvarchar](50) NOT NULL,
	[MaNCC] [nvarchar](50) NOT NULL,
	[TenLK] [nvarchar](max) NULL,
	[BaoHanh] [nvarchar](50) NOT NULL,
	[XuatXu] [nvarchar](50) NULL,
	[TinhTrang] [nvarchar](50) NOT NULL,
	[DonViTinh] [nvarchar](50) NOT NULL,
	[DonGia] [int] NULL,
	[SoLuongTon] [int] NOT NULL,
	[KhuyenMai] [int] NULL,
	[HinhAnh] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](50) NULL,
	[MaNSX] [nvarchar](50) NULL,
 CONSTRAINT [PK_LinhKien] PRIMARY KEY CLUSTERED 
(
	[MaLK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiLinhKien]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiLinhKien](
	[MaLLK] [nvarchar](50) NOT NULL,
	[TenLLK] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_LoaiLinhKien] PRIMARY KEY CLUSTERED 
(
	[MaLLK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [nvarchar](50) NOT NULL,
	[TenNCC] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](200) NULL,
	[DienThoai] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](50) NOT NULL,
	[MaCV] [nvarchar](50) NOT NULL,
	[TenNV] [nvarchar](50) NOT NULL,
	[GioiTinh] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[NgaySinh] [datetime] NULL,
	[DienThoai] [nvarchar](50) NULL,
	[CMND] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[HinhAnh] [nvarchar](max) NULL,
	[UserName] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaSanXuat]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaSanXuat](
	[MaNSX] [nvarchar](50) NOT NULL,
	[TenNSX] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](200) NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NhaSanXuat] PRIMARY KEY CLUSTERED 
(
	[MaNSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuBaoHanh]    Script Date: 05/28/2025 10:34:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuBaoHanh](
	[MaPBH] [nvarchar](50) NOT NULL,
	[MaKH] [nvarchar](50) NOT NULL,
	[MaNV] [nvarchar](50) NULL,
	[NgayLapPhieu] [datetime] NULL,
	[NgayLayHang] [datetime] NULL,
	[QuyTrinh] [nvarchar](50) NULL,
	[TrangThai] [nchar](10) NULL,
 CONSTRAINT [PK_PhieuBaoHanh_1] PRIMARY KEY CLUSTERED 
(
	[MaPBH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChucVu] ([MaCV], [TenCV], [NhanVien], [KhachHang], [LinhKien], [BanHang], [NhaCungCap], [LoaiLK], [NhapKho], [BaoHanh], [PhanQuyen], [ThongKe], [HoaDon], [Setting], [TrangThai], [NhaSanXuat]) VALUES (N'CV01', N'Nhân Viên Quản Trị', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, N'1         ', 1)
INSERT [dbo].[ChucVu] ([MaCV], [TenCV], [NhanVien], [KhachHang], [LinhKien], [BanHang], [NhaCungCap], [LoaiLK], [NhapKho], [BaoHanh], [PhanQuyen], [ThongKe], [HoaDon], [Setting], [TrangThai], [NhaSanXuat]) VALUES (N'CV02', N'Nhân Viên Bán Hàng', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, N'1         ', 0)
INSERT [dbo].[ChucVu] ([MaCV], [TenCV], [NhanVien], [KhachHang], [LinhKien], [BanHang], [NhaCungCap], [LoaiLK], [NhapKho], [BaoHanh], [PhanQuyen], [ThongKe], [HoaDon], [Setting], [TrangThai], [NhaSanXuat]) VALUES (N'CV03', N'Nhân Viên Nhập', 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, N'1         ', 0)
GO
INSERT [dbo].[CT_HoaDonBanHang] ([MaHDBH], [MaLK], [SoLuong], [DonGia], [KhuyenMai], [ThanhTien], [TrangThai]) VALUES (N'HDB00', N'LK00', 1, CAST(439000 AS Decimal(28, 0)), CAST(0 AS Decimal(28, 0)), CAST(439000 AS Decimal(28, 0)), N'1')
INSERT [dbo].[CT_HoaDonBanHang] ([MaHDBH], [MaLK], [SoLuong], [DonGia], [KhuyenMai], [ThanhTien], [TrangThai]) VALUES (N'HDB01', N'LK02', 1, CAST(2000000 AS Decimal(28, 0)), CAST(0 AS Decimal(28, 0)), CAST(2000000 AS Decimal(28, 0)), N'1')
INSERT [dbo].[CT_HoaDonBanHang] ([MaHDBH], [MaLK], [SoLuong], [DonGia], [KhuyenMai], [ThanhTien], [TrangThai]) VALUES (N'HDB01', N'LK03', 1, CAST(50000000 AS Decimal(28, 0)), CAST(10 AS Decimal(28, 0)), CAST(45000000 AS Decimal(28, 0)), N'1')
INSERT [dbo].[CT_HoaDonBanHang] ([MaHDBH], [MaLK], [SoLuong], [DonGia], [KhuyenMai], [ThanhTien], [TrangThai]) VALUES (N'HDB02', N'LK02', 1, CAST(2000000 AS Decimal(28, 0)), CAST(0 AS Decimal(28, 0)), CAST(2000000 AS Decimal(28, 0)), N'1')
GO
INSERT [dbo].[CT_HoaDonNhapHang] ([MaHDNH], [MaLK], [SoLuong], [DonGia], [KhuyenMai], [ThanhTien], [TrangThai]) VALUES (N'HDN00', N'LK00', 1, CAST(20000 AS Decimal(28, 0)), CAST(0 AS Decimal(28, 0)), CAST(20000 AS Decimal(28, 0)), N'1         ')
INSERT [dbo].[CT_HoaDonNhapHang] ([MaHDNH], [MaLK], [SoLuong], [DonGia], [KhuyenMai], [ThanhTien], [TrangThai]) VALUES (N'HDN01', N'LK02', 10, CAST(1500000 AS Decimal(28, 0)), CAST(0 AS Decimal(28, 0)), CAST(15000000 AS Decimal(28, 0)), N'1         ')
GO
INSERT [dbo].[CT_PhieuBaoHanh] ([MaPBH], [TenLK], [SoLuong], [GhiChu], [TrangThai]) VALUES (N'PBH00', N'Chuột có dây Gaming Asus TUF M3 GEN II', 1, N'hư', N'1')
GO
INSERT [dbo].[HoaDonBanHang] ([MaHDBH], [MaKH], [MaNV], [NgayLapHDBH], [TongTien], [TrangThai]) VALUES (N'HDB00', N'KH00', N'NV00', CAST(N'2025-05-17T21:19:25.390' AS DateTime), CAST(439000 AS Decimal(28, 0)), N'1')
INSERT [dbo].[HoaDonBanHang] ([MaHDBH], [MaKH], [MaNV], [NgayLapHDBH], [TongTien], [TrangThai]) VALUES (N'HDB01', N'KH02', N'NV00', CAST(N'2025-05-27T14:12:35.883' AS DateTime), CAST(47000000 AS Decimal(28, 0)), N'1')
INSERT [dbo].[HoaDonBanHang] ([MaHDBH], [MaKH], [MaNV], [NgayLapHDBH], [TongTien], [TrangThai]) VALUES (N'HDB02', N'KH02', N'NV00', CAST(N'2025-05-28T20:56:41.767' AS DateTime), CAST(2000000 AS Decimal(28, 0)), N'1')
GO
INSERT [dbo].[HoaDonNhapHang] ([MaHDNH], [MaNCC], [MaNV], [NgayLapHDNH], [TongTien], [TrangThai], [MaNSX]) VALUES (N'HDN00', N'NCC04', N'NV00', CAST(N'2025-05-13T16:12:25.910' AS DateTime), CAST(10000 AS Decimal(28, 0)), N'1', N'NSX01')
INSERT [dbo].[HoaDonNhapHang] ([MaHDNH], [MaNCC], [MaNV], [NgayLapHDNH], [TongTien], [TrangThai], [MaNSX]) VALUES (N'HDN01', N'NCC01', N'NV00', CAST(N'2025-05-13T16:12:25.000' AS DateTime), CAST(15000000 AS Decimal(28, 0)), N'1', N'NSX01')
GO
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [DienThoai], [DiaChi], [TrangThai]) VALUES (N'KH00', N'Nguyễn Thị C', N'Nữ', N'0123456788', N'Cần Thơ ', N'1')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [DienThoai], [DiaChi], [TrangThai]) VALUES (N'KH01', N'Trần Văn B', N'Nam', N'0394121584', N'Cần Thơ ', N'1')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [DienThoai], [DiaChi], [TrangThai]) VALUES (N'KH02', N'Nguyễn Văn A', N'Nam', N'0123456789', N'ABC', N'1')
GO
INSERT [dbo].[LinhKien] ([MaLK], [MaLLK], [MaNCC], [TenLK], [BaoHanh], [XuatXu], [TinhTrang], [DonViTinh], [DonGia], [SoLuongTon], [KhuyenMai], [HinhAnh], [TrangThai], [MaNSX]) VALUES (N'LK00', N'LLK06', N'NCC02', N'Chuột có dây Gaming Asus TUF M3 GEN II', N'36 Tháng', N'Việt Nam', N'Mới', N'Cái', 439000, 10, 0, N'73017_chuot_gaming_co_day_asus_tuf_m3_gen_ii_90mp0320_bmua00_1.jpg', N'1', N'NSX12')
INSERT [dbo].[LinhKien] ([MaLK], [MaLLK], [MaNCC], [TenLK], [BaoHanh], [XuatXu], [TinhTrang], [DonViTinh], [DonGia], [SoLuongTon], [KhuyenMai], [HinhAnh], [TrangThai], [MaNSX]) VALUES (N'LK01', N'LLK07', N'NCC00', N'Bàn phím có dây Logitech K120', N'36 Tháng', N'Việt Nam', N'Mới', N'Cái', 180000, 20, 0, N'download.jpg', N'1', N'NSX12')
INSERT [dbo].[LinhKien] ([MaLK], [MaLLK], [MaNCC], [TenLK], [BaoHanh], [XuatXu], [TinhTrang], [DonViTinh], [DonGia], [SoLuongTon], [KhuyenMai], [HinhAnh], [TrangThai], [MaNSX]) VALUES (N'LK02', N'LLK00', N'NCC01', N'Intel Core i3-12100f', N'36 Tháng', N'Trung Quốc', N'Mới', N'Cái', 2000000, 18, 0, N'63413_cpu_intel_core_i3_12100f_1.jpg', N'1', N'NSX01')
INSERT [dbo].[LinhKien] ([MaLK], [MaLLK], [MaNCC], [TenLK], [BaoHanh], [XuatXu], [TinhTrang], [DonViTinh], [DonGia], [SoLuongTon], [KhuyenMai], [HinhAnh], [TrangThai], [MaNSX]) VALUES (N'LK03', N'LLK01', N'NCC03', N'NVIDIA RTX 5090', N'36 Tháng', N'Trung Quốc', N'Mới', N'Cái', 50000000, 9, 10, N'250-11155-vga-msi-geforce-rtx-5090-32g-gaming-trio-oc_2_main.jpeg', N'1', N'NSX03')
INSERT [dbo].[LinhKien] ([MaLK], [MaLLK], [MaNCC], [TenLK], [BaoHanh], [XuatXu], [TinhTrang], [DonViTinh], [DonGia], [SoLuongTon], [KhuyenMai], [HinhAnh], [TrangThai], [MaNSX]) VALUES (N'LK04', N'LLK03', N'NCC00', N'SSD NVME Gen 4x4 1TB', N'36 Tháng', N'Nhật Bản', N'Mới', N'Cái', 1200000, 40, 0, N'1596272871-722-o-cung-ssd-m2-pcie-1tb-sk-hynix-pc401-nvme-2280-1-420x420.jpg', N'1', N'NSX06')
GO
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK00', N'CPU', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK01', N'GPU', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK02', N'RAM', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK03', N'Ổ cứng', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK04', N'Pin', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK05', N'Mainboard', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK06', N'Chuột', N'1')
INSERT [dbo].[LoaiLinhKien] ([MaLLK], [TenLLK], [TrangThai]) VALUES (N'LLK07', N'Bàn phím', N'1')
GO
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [Email], [TrangThai]) VALUES (N'NCC00', N'Nguyễn Kim', N'Ð. 30/4, An Phú, Ninh Ki?u, C?n Tho', N'0343754517', N'1234@gmail.com', N'1')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [Email], [TrangThai]) VALUES (N'NCC01', N'FPT Shop', N'Số 10, Phạm Van Bach, Phùng Dach Vang Cầu Giấy, Hà Nội', N'0123456789', N'fptshop@gmail.com', N'1')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [Email], [TrangThai]) VALUES (N'NCC02', N'Phong Vũ', N'Tầng 5, 117-119-121 Nguyễn Du - Phu?ng B?n Thành - Quân 1 - TP. H? Chí Minh', N'02862908779', N'cskh@phongvu.vn', N'1')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [Email], [TrangThai]) VALUES (N'NCC03', N'AN PHAT COMPUTER', N'Tầng 5, Số 49 phố Thái Hà, Phường Trung Li?t, Quận Ðống Đa, Thành ph? Hà N?i, Vi?t Nam', N'04846483746', N'anphat123@gmail.com', N'1')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [Email], [TrangThai]) VALUES (N'NCC04', N'Thái Hà', N'Số 6, Ngõ 161, Thái Hà, Hà Nội', N'0911082468', N'linhkienlaptopthaiha@gmail.com', N'1')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [Email], [TrangThai]) VALUES (N'NCC05', N'Công ty TNHH TM DV Tin Học Niềm Tin Việt', N'89B Tôn Th?t Thuy?t, Phuờng 16, Quận 4, TPHCM', N'0904580004', N'laptopcarevietnam@gmail.com', N'1')
GO
INSERT [dbo].[NhanVien] ([MaNV], [MaCV], [TenNV], [GioiTinh], [Email], [NgaySinh], [DienThoai], [CMND], [DiaChi], [HinhAnh], [UserName], [PassWord], [TrangThai]) VALUES (N'NV00', N'CV01', N'Nguyễn Hoàng Minh', N'Nam', N'hminh180320@gmail.com', CAST(N'2005-03-18T00:00:00.000' AS DateTime), N'0703748790', N'272947647', N'TPHCM', N'images (1).jpg', N'hoangminh', N'BAEEFADFE3736E2DDC9C0487CDD2695D', N'1')
INSERT [dbo].[NhanVien] ([MaNV], [MaCV], [TenNV], [GioiTinh], [Email], [NgaySinh], [DienThoai], [CMND], [DiaChi], [HinhAnh], [UserName], [PassWord], [TrangThai]) VALUES (N'NV01', N'CV02', N'Nguyễn Ngọc Thảo Vân', N'Nữ', N'Không', CAST(N'2005-12-24T00:00:00.000' AS DateTime), N'0564837672', N'272947645', N'Long Khánh ,Đồng Nai', N'images.jpg', N'thaovan', N'84BA6646D4507C878CBB5408B10C3014', N'1')
INSERT [dbo].[NhanVien] ([MaNV], [MaCV], [TenNV], [GioiTinh], [Email], [NgaySinh], [DienThoai], [CMND], [DiaChi], [HinhAnh], [UserName], [PassWord], [TrangThai]) VALUES (N'NV02', N'CV03', N'Danh Bình Tính', N'Nam', N'Không', CAST(N'2000-12-01T00:00:00.000' AS DateTime), N'0938635726', N'2729385463', N'Phú Trung,Tân Phú ,Đồng Na', N'photo-1543852786-1cf6624b9987.jpg', N'binhtinh', N'A2B4BBFA04B4D87752D097E83FB85E91', N'1')
INSERT [dbo].[NhanVien] ([MaNV], [MaCV], [TenNV], [GioiTinh], [Email], [NgaySinh], [DienThoai], [CMND], [DiaChi], [HinhAnh], [UserName], [PassWord], [TrangThai]) VALUES (N'NV04', N'CV02', N'Lâm Tâm Nguyên', N'Nam', N'Không', CAST(N'2006-08-22T00:00:00.000' AS DateTime), N'0343754512', N'2727216445', N'HCM', N'images (2).jpg', N'tamnguyen', N'3B340E7C1E269722340F024674356A3E', N'1')
GO
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX01', N'Intel', N'Lô 12 KCN Cao Đường D1 - Phường Tân Phú - Quận 9 - TP. Hồ Chí Minh', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX02', N'AMD', N'Thôn 14, Xã Ea Đar, Huyện Ea Kar, Tỉnh Đắk Lắk, Việt Nam', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX03', N'NVIDIA', N'Việt Nam', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX04', N'SamSung', N'Q Bắc Từ Liêm, Hà Nội', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX05', N'Kington', N'P Trần Quang Diệu, TP Quy Nhon, T Bình Ð?nh', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX06', N'SK Hynix', N'P2501-5, tầng 25, Keangnam Hanoi Lanmark Tower, E6, KĐTCG, Phường Mễ Trì, Quận Nam Từ Liêm, Thành phố Hà Nội, Việt Nam', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX07', N'Panasonic', N'Xã Kim Chung, Huy?n Ðông Anh, Hà N?i,', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX08', N'Quanta', N'45 Ngô Đức kế, Phường Bến Nghé, Quận 1, Thành phố Hồ Chí Minh, Việt Nam', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX09', N'Compal Electronics', N'Lô B1-2 (thuộc Lô B1), Khu công nghiệp Liên Hà Thái (Green i, Thị trấn Diêm Điền, Huyện Thái Thụy, Tỉnh Thái Bình, Việt Nam', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX10', N'Lite-On', N'số 149, đường 10, KCN VSIP - Thủy Nguyên - Hải Phòng', N'1')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [TrangThai]) VALUES (N'NSX12', N'ASUS', N'Tầng 8, tòa nhà Viet Tower, số 1 Thái Hà, Phường Trung Liệt, Quận Đống đa, Thành phố Hà Nội', N'1')
GO
INSERT [dbo].[PhieuBaoHanh] ([MaPBH], [MaKH], [MaNV], [NgayLapPhieu], [NgayLayHang], [QuyTrinh], [TrangThai]) VALUES (N'PBH00', N'KH00', N'NV00', CAST(N'2025-05-17T00:00:00.000' AS DateTime), CAST(N'2025-05-17T00:00:00.000' AS DateTime), N'Đang Xử Lý', N'1         ')
GO
ALTER TABLE [dbo].[CT_HoaDonBanHang]  WITH CHECK ADD  CONSTRAINT [FK__CT_HoaDon__MAHDB__7B5B524B] FOREIGN KEY([MaHDBH])
REFERENCES [dbo].[HoaDonBanHang] ([MaHDBH])
GO
ALTER TABLE [dbo].[CT_HoaDonBanHang] CHECK CONSTRAINT [FK__CT_HoaDon__MAHDB__7B5B524B]
GO
ALTER TABLE [dbo].[CT_HoaDonBanHang]  WITH CHECK ADD  CONSTRAINT [FK__CT_HoaDonB__MALK__7C4F7684] FOREIGN KEY([MaLK])
REFERENCES [dbo].[LinhKien] ([MaLK])
GO
ALTER TABLE [dbo].[CT_HoaDonBanHang] CHECK CONSTRAINT [FK__CT_HoaDonB__MALK__7C4F7684]
GO
ALTER TABLE [dbo].[CT_HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [FK__CT_HoaDon__MAHDN__7E37BEF6] FOREIGN KEY([MaHDNH])
REFERENCES [dbo].[HoaDonNhapHang] ([MaHDNH])
GO
ALTER TABLE [dbo].[CT_HoaDonNhapHang] CHECK CONSTRAINT [FK__CT_HoaDon__MAHDN__7E37BEF6]
GO
ALTER TABLE [dbo].[CT_HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [FK__CT_HoaDonN__MALK__7D439ABD] FOREIGN KEY([MaLK])
REFERENCES [dbo].[LinhKien] ([MaLK])
GO
ALTER TABLE [dbo].[CT_HoaDonNhapHang] CHECK CONSTRAINT [FK__CT_HoaDonN__MALK__7D439ABD]
GO
ALTER TABLE [dbo].[CT_PhieuBaoHanh]  WITH CHECK ADD  CONSTRAINT [FK__CT_PhieuBa__MABH__797309D9] FOREIGN KEY([MaPBH])
REFERENCES [dbo].[PhieuBaoHanh] ([MaPBH])
GO
ALTER TABLE [dbo].[CT_PhieuBaoHanh] CHECK CONSTRAINT [FK__CT_PhieuBa__MABH__797309D9]
GO
ALTER TABLE [dbo].[HoaDonBanHang]  WITH CHECK ADD  CONSTRAINT [FK__HoaDonBanH__MAKH__778AC167] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDonBanHang] CHECK CONSTRAINT [FK__HoaDonBanH__MAKH__778AC167]
GO
ALTER TABLE [dbo].[HoaDonBanHang]  WITH CHECK ADD  CONSTRAINT [FK__HoaDonBanH__MANV__76969D2E] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDonBanHang] CHECK CONSTRAINT [FK__HoaDonBanH__MANV__76969D2E]
GO
ALTER TABLE [dbo].[HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [FK__HoaDonNha__MANHA__73BA3083] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[HoaDonNhapHang] CHECK CONSTRAINT [FK__HoaDonNha__MANHA__73BA3083]
GO
ALTER TABLE [dbo].[HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [FK__HoaDonNhap__MANV__72C60C4A] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDonNhapHang] CHECK CONSTRAINT [FK__HoaDonNhap__MANV__72C60C4A]
GO
ALTER TABLE [dbo].[HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [FK_MANSX_HDNH] FOREIGN KEY([MaNSX])
REFERENCES [dbo].[NhaSanXuat] ([MaNSX])
GO
ALTER TABLE [dbo].[HoaDonNhapHang] CHECK CONSTRAINT [FK_MANSX_HDNH]
GO
ALTER TABLE [dbo].[LinhKien]  WITH CHECK ADD  CONSTRAINT [FK__LinhKien__MALOAI__74AE54BC] FOREIGN KEY([MaLLK])
REFERENCES [dbo].[LoaiLinhKien] ([MaLLK])
GO
ALTER TABLE [dbo].[LinhKien] CHECK CONSTRAINT [FK__LinhKien__MALOAI__74AE54BC]
GO
ALTER TABLE [dbo].[LinhKien]  WITH CHECK ADD  CONSTRAINT [FK_MANCC] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[LinhKien] CHECK CONSTRAINT [FK_MANCC]
GO
ALTER TABLE [dbo].[LinhKien]  WITH CHECK ADD  CONSTRAINT [FK_MANSX] FOREIGN KEY([MaNSX])
REFERENCES [dbo].[NhaSanXuat] ([MaNSX])
GO
ALTER TABLE [dbo].[LinhKien] CHECK CONSTRAINT [FK_MANSX]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK__NhanVien__MACV__71D1E811] FOREIGN KEY([MaCV])
REFERENCES [dbo].[ChucVu] ([MaCV])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK__NhanVien__MACV__71D1E811]
GO
ALTER TABLE [dbo].[PhieuBaoHanh]  WITH CHECK ADD  CONSTRAINT [FK_MaKH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[PhieuBaoHanh] CHECK CONSTRAINT [FK_MaKH]
GO
ALTER TABLE [dbo].[PhieuBaoHanh]  WITH CHECK ADD  CONSTRAINT [FK_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[PhieuBaoHanh] CHECK CONSTRAINT [FK_MaNV]
GO
USE [master]
GO
ALTER DATABASE [PM_QLBanLinhKien_Laptop] SET  READ_WRITE 
GO
