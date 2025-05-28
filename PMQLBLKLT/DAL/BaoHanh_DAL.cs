using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DTO;
using System.Data.SqlClient;
using System.Globalization;
namespace DAL
{
    public class BaoHanh_DAL
    {
        KetNoiDatabase KetNoi = new KetNoiDatabase();

        public DataTable GetPBH(string condition)
        {
            return KetNoi.GetDataTable(" select MaPBH,kH.TenKH,NV.TenNV,NgayLapPhieu,NgayLayHang,QuyTrinh From PhieuBaoHanh PBH,NhanVien NV,KhachHang KH Where PBH.TrangThai=N'1' and PBH.MaNV=NV.MaNV and KH.MaKH=PBH.MaKH" + condition);
        }
        public DataTable PhatSinhMa(string condition)
        {
            return KetNoi.GetDataTable("Select * From PhieuBaoHanh" + condition);
        }
        public DataTable HienThiHDBH(string condition)
        {
            return KetNoi.GetDataTable("select * From HoaDonBanHang" + condition);
        }

        public DataTable HienThiCT_PhieuBaoHanh(string conditon)
        {
            return KetNoi.GetDataTable("select TenLK,SoLuong,GhiChu From CT_PhieuBaoHanh Where TrangThai=N'1'" + conditon);
        }

        public DataTable HienThiCT_PhieuBaoHanhTheoMa(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }
        public void ThemPBH(PhieuBaoHanh ex)
        {
            //KetNoi.ExecuteReader(@"Insert Into PhieuBaoHanh Values(N'" + ex.MaPBH + "',N'" + ex.MaKH + "',N'" + ex.MaNV + "','" + ex.NgayLap + "','" + ex.NgayLayHang + "',N'" + ex.QuyTrinh + "' ,N'" + ex.TrangThai + "')");

            // làm lại
            try
            {
                // Tạo câu lệnh SQL thêm vào bảng PhieuBaoHanh
                string query = @"INSERT INTO PhieuBaoHanh(MaPBH, MaKH, MaNV, NgayLapPhieu, NgayLayHang, QuyTrinh, TrangThai)
                     VALUES(@MaPBH, @MaKH, @MaNV, @NgayLap, @NgayLayHang, @QuyTrinh, @TrangThai)";

                KetNoi.OpenConnect();

                using (SqlCommand cmd = new SqlCommand(query, KetNoiDatabase.ConnectDB))
                {
                    cmd.Parameters.AddWithValue("@MaPBH", ex.MaPBH);
                    cmd.Parameters.AddWithValue("@MaKH", ex.MaKH);
                    cmd.Parameters.AddWithValue("@MaNV", ex.MaNV);
                   
                    cmd.Parameters.AddWithValue("@NgayLap", Convert.ToDateTime(ex.NgayLap));
                    
                    cmd.Parameters.AddWithValue("@NgayLayHang", Convert.ToDateTime(ex.NgayLayHang));
                    cmd.Parameters.AddWithValue("@QuyTrinh", ex.QuyTrinh);
                    cmd.Parameters.AddWithValue("@TrangThai", ex.TrangThai);

                    // Thực thi câu lệnh
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {
                throw new Exception("Lỗi khi thêm phiếu bảo hành: " + e.Message);
            }
            finally
            {
                KetNoi.CloseConnect();
            }
        }

        public void ThemCTPhieuBaoHanh(CT_PhieuBaoHanh ex)
        {
            //KetNoi.ExecuteReader(@"insert into CT_PhieuBaoHanh values(N'" + ex.MaPBH + "',N'" + ex.TenLK + "'," + ex.SoLuong + ",N'" + ex.GhiChu + "',N'" + ex.TrangThai + "')");

            //làm lại

            try
            {
                // Kiểm tra xem MaPBH có tồn tại trong bảng PhieuBaoHanh trước khi thêm vào CT_PhieuBaoHanh
                string checkQuery = "SELECT COUNT(*) FROM PhieuBaoHanh WHERE MaPBH = @MaPBH";

                KetNoi.OpenConnect();

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, KetNoiDatabase.ConnectDB))
                {
                    checkCmd.Parameters.AddWithValue("@MaPBH", ex.MaPBH);

                    int count = (int)checkCmd.ExecuteScalar();  // Đếm số lượng bản ghi có MaPBH tương ứng

                    if (count == 0)
                    {
                        throw new Exception("MaPBH không tồn tại trong bảng PhieuBaoHanh.");
                    }
                }

                // Thêm chi tiết vào CT_PhieuBaoHanh nếu MaPBH hợp lệ
                string query = @"INSERT INTO CT_PhieuBaoHanh(MaPBH, TenLK, SoLuong, GhiChu, TrangThai)
                     VALUES(@MaPBH, @TenLK, @SoLuong, @GhiChu, @TrangThai)";

                using (SqlCommand cmd = new SqlCommand(query, KetNoiDatabase.ConnectDB))
                {
                    cmd.Parameters.AddWithValue("@MaPBH", ex.MaPBH);
                    cmd.Parameters.AddWithValue("@TenLK", ex.TenLK);
                    cmd.Parameters.AddWithValue("@SoLuong", ex.SoLuong);
                    cmd.Parameters.AddWithValue("@GhiChu", ex.GhiChu);
                    cmd.Parameters.AddWithValue("@TrangThai", ex.TrangThai);

                    // Thực thi câu lệnh
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {
                throw new Exception("Lỗi khi thêm chi tiết phiếu bảo hành: " + e.Message);
            }
            finally
            {
                KetNoi.CloseConnect();
            }
        }

        public DataTable GetNhanVien(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }

        public DataTable DanhSachKH(string condition)
        {
            return KetNoi.GetDataTable("Select * From KhachHang Where TrangThai=N'1' " + condition);
        }

        public DataTable DSSP(string condition)
        {
            return KetNoi.GetDataTable("Select MaLK,TenLK From LinhKien" + condition);
        }

        public void XoaCTPhieuBaoHanh(CT_PhieuBaoHanh ex)
        {
            KetNoi.ExecuteReader(@"Update CT_PhieuBaoHanh Set TrangThai=N'0' where MaPBH=N'" + ex.MaPBH + "'");
        }

        public void XoaPhieuBaoHanh(PhieuBaoHanh ex)
        {
            KetNoi.ExecuteReader(@"Update PhieuBaoHanh Set TrangThai=N'0' Where MaPBH=N'" + ex.MaPBH + "'");
        }

        public void Update_CTPBH(CT_PhieuBaoHanh ex)
        {
            KetNoi.ExecuteReader(@"update CT_PhieuBaoHanh Set SoLuong=" + ex.SoLuong + ",GhiChu=N'" + ex.GhiChu + "' Where MaPBH=N'" + ex.MaPBH + "' and TenLK=N'" + ex.TenLK + "'");
        }
        public void Update_PBH(PhieuBaoHanh ex)
        {
            KetNoi.ExecuteReader(@"update PhieuBaoHanh Set QuyTrinh=N'" + ex.QuyTrinh + "'  Where MaPBH=N'" + ex.MaPBH + "' ");
        }

        public DataTable TimHD(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }

        public DataTable LayThongTinKH(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }
    }
}
