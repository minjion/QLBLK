﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DTO;
using System.Data.SqlClient;
namespace DAL
{
    public class NhapKho_DAL
    {
        KetNoiDatabase KetNoi = new KetNoiDatabase();

        public DataTable GetData(string Condition)
        {
            return KetNoi.GetDataTable("Select MaLK,TenLK from LinhKien where TrangThai=N'1' " + Condition);
        }
        public DataTable GetDSSP(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }

        public DataTable GetNhanVien(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }

        public DataTable GetNCC(string condition)
        {
            return KetNoi.GetDataTable("Select * From NhaCungCap" + condition);
        }

        public DataTable GetNSX(string condition)
        {
            return KetNoi.GetDataTable("Select * From NhaSanXuat" + condition);
        }

        public DataTable HienThiHDN(string condition)
        {
            //return KetNoi.GetDataTable("select MaHDNH,NCC.TenNCC,NV.TenNV,NgayLapHDNH,TongTien,HD.TrangThai From HoaDonNhapHang HD,NhaCungCap NCC,NhanVien NV Where NV.MaNV=HD.MaNV and NCC.MaNCC=HD.MaNCC and HD.TrangThai=N'1'" + condition);
            return KetNoi.GetDataTable("select MaHDNH,NCC.TenNCC,NSX.TenNSX,NV.TenNV,NgayLapHDNH,TongTien,HD.TrangThai From HoaDonNhapHang as HD,NhaCungCap as NCC,NhanVien as NV, NhaSanXuat as NSX Where NV.MaNV=HD.MaNV and NCC.MaNCC=HD.MaNCC and HD.MaNSX = NSX.MaNSX and HD.TrangThai=N'1'" + condition);
            //return KetNoi.GetDataTable(""+ condition);
        }

        public DataTable HienThiCTHDNH(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }
        public DataTable PhatSinhMa(string condition)
        {
            return KetNoi.GetDataTable("Select * From HoaDonNhapHang" + condition);
        }

        public DataTable LoadNCC(string codition)
        {
            return KetNoi.GetDataTable("select ncc.TenNCC,ncc.MaNCC  from NhaCungCap ncc,LinhKien lk where lk.MaNCC=ncc.MaNCC and lk.MaLK=N'" + codition + "'");
        }

        public void AddHoaDon(HoaDonNhapHang ex)
        {
            //            KetNoi.ExecuteReader(@"insert into HoaDonNhapHang(MaHDNH,MaNCC,MaNSX,MaNV,NgayLapHDNH,TongTien,TrangThai)
            //Values(N'" + ex.MaHDNH + "',N'" + ex.MaNCC + "',N'" + ex.MaNSX + "',N'" + ex.MaNV + "','" + ex.NgayLapHDNH + "'," + ex.TongTien + ",N'" + ex.TrangThai + "')");

            //sua lại
            try
            {
                // Tạo câu lệnh SQL thêm vào bảng HoaDonNhapHang
                string query = @"INSERT INTO HoaDonNhapHang(MaHDNH, MaNCC, MaNSX, MaNV, NgayLapHDNH, TongTien, TrangThai)
                         VALUES(@MaHDNH, @MaNCC,@MaNSX, @MaNV, @NgayLapHDNH, @TongTien, @TrangThai)";

                KetNoi.OpenConnect();
                // Sử dụng SqlCommand với tham số an toàn
                using (SqlCommand cmd = new SqlCommand(query, KetNoiDatabase.ConnectDB))
                {
                    cmd.Parameters.AddWithValue("@MaHDNH", ex.MaHDNH);
                    cmd.Parameters.AddWithValue("@MaNCC", ex.MaNCC);
                    cmd.Parameters.AddWithValue("@MaNSX", ex.MaNSX);
                    cmd.Parameters.AddWithValue("@MaNV", ex.MaNV);
                    cmd.Parameters.AddWithValue("@NgayLapHDNH", ex.NgayLapHDNH);
                    cmd.Parameters.AddWithValue("@TongTien", ex.TongTien);
                    cmd.Parameters.AddWithValue("@TrangThai", ex.TrangThai);

                    // Thực thi câu lệnh
                    cmd.ExecuteNonQuery();

                }
            }
            catch (Exception e)
            {
                throw new Exception("Lỗi khi thêm hóa đơn: " + e.Message);
            }
            finally { KetNoi.CloseConnect(); }
        }

        public void AddCTHD(CT_HoaDonNhapHang exx)
        {
            //            KetNoi.ExecuteReader(@"insert into CT_HoaDonNhapHang(MaHDNH,MaLK,SoLuong,DonGia,KhuyenMai,ThanhTien,TrangThai)
            //values(N'" + exx.MaHDNH + "',N'" + exx.MaLK + "'," + exx.SoLuong + "," + exx.DonGia + "," + exx.KhuyenMai + "," + exx.ThanhTien + ",N'" + exx.TrangThai + "')");

            //sua lại
            try
            {
                // Kiểm tra xem MaHDNH có tồn tại trong bảng HoaDonNhapHang trước khi thêm vào CT_HoaDonNhapHang
                string checkQuery = "SELECT COUNT(*) FROM HoaDonNhapHang WHERE MaHDNH = @MaHDNH";

                KetNoi.OpenConnect();

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, KetNoiDatabase.ConnectDB))
                {
                    checkCmd.Parameters.AddWithValue("@MaHDNH", exx.MaHDNH);

                    int count = (int)checkCmd.ExecuteScalar();  // Đếm số lượng bản ghi có MaHDNH tương ứng

                    if (count == 0)
                    {
                        throw new Exception("MaHDNH không tồn tại trong bảng HoaDonNhapHang.");
                    }
                }

                // Thêm chi tiết vào CT_HoaDonNhapHang nếu MaHDNH hợp lệ
                string query = @"INSERT INTO CT_HoaDonNhapHang(MaHDNH, MaLK, SoLuong, DonGia, KhuyenMai, ThanhTien, TrangThai)
                         VALUES(@MaHDNH, @MaLK, @SoLuong, @DonGia, @KhuyenMai, @ThanhTien, @TrangThai)";

                using (SqlCommand cmd = new SqlCommand(query, KetNoiDatabase.ConnectDB))
                {
                    cmd.Parameters.AddWithValue("@MaHDNH", exx.MaHDNH);
                    cmd.Parameters.AddWithValue("@MaLK", exx.MaLK);
                    cmd.Parameters.AddWithValue("@SoLuong", exx.SoLuong);
                    cmd.Parameters.AddWithValue("@DonGia", exx.DonGia);
                    cmd.Parameters.AddWithValue("@KhuyenMai", exx.KhuyenMai);
                    cmd.Parameters.AddWithValue("@ThanhTien", exx.ThanhTien);
                    cmd.Parameters.AddWithValue("@TrangThai", exx.TrangThai);

                    // Thực thi câu lệnh
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {
                throw new Exception("Lỗi khi thêm chi tiết hóa đơn: " + e.Message);
            }
            finally
            {
                KetNoi.CloseConnect();
            }
        }

        public void DeleteHoaDonNhap(HoaDonNhapHang ex)
        {
            KetNoi.ExecuteReader(@"Update HoaDonNhapHang Set TrangThai=N'0' Where MaHDNH=N'" + ex.MaHDNH + "'");
        }

        public void DeleteCT_HoaDonNhap(CT_HoaDonNhapHang ex)
        {
            KetNoi.ExecuteReader(@"Update CT_HoaDonNhapHang set TrangThai=N'0' Where MaHDNH=N'" + ex.MaHDNH + "' ");
        }

        public void XoaCTHoaDonNhap(CT_HoaDonNhapHang ex)
        {
            KetNoi.ExecuteReader(@"Delete From CT_HoaDonNhapHang Where MaHDNH=N'" + ex.MaHDNH + "' and MaLK=N'" + ex.MaLK + "'");
        }
        public void UpdateCTHDN(CT_HoaDonNhapHang ex)
        {
            KetNoi.ExecuteReader(@"update CT_HoaDonNhapHang Set SoLuong=" + ex.SoLuong + ",DonGia=" + ex.DonGia + ",KhuyenMai=" + ex.KhuyenMai + ",ThanhTien=" + ex.ThanhTien + " Where MaHDNH=N'" + ex.MaHDNH + "' and MaLK=N'" + ex.MaLK + "' ");
        }

        public void UpdateHDN(HoaDonNhapHang ex)
        {
            KetNoi.ExecuteReader(@" update HoaDonNhapHang Set NgayLapHDNH='" + ex.NgayLapHDNH + "',TongTien=" + ex.TongTien + " Where MaHDNH=N'" + ex.MaHDNH + "'");
        }

        public void CapNhatSLKho(LinhKien ex)
        {
            KetNoi.ExecuteReader(@"Update LinhKien Set SoLuongTon=" + ex.SoLuongTon + " Where MaLK=N'" + ex.MaLK + "'");
        }
        public void CapNhatSLKho1(LinhKien ex)
        {
            KetNoi.ExecuteReader(@"Update LinhKien Set SoLuongTon=" + ex.SoLuongTon + ",DonGia=" + ex.DonGia + " Where MaLK=N'" + ex.MaLK + "'");
        }
        public DataTable LayDSSP(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }
    }
}
