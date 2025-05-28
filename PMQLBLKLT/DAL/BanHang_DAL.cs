using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using DAL;
using System.Data;
using System.Data.SqlClient;
namespace DAL
{
    public class BanHang_DAL
    {
        KetNoiDatabase KetNoi = new KetNoiDatabase();
        //  LẤY DỮ LIỆU
        public DataTable GetData(string Condition)
        {
            return KetNoi.GetDataTable("Select MaLK,TenLK from LinhKien Order By TenLK ASC" + Condition);
        }
        public DataTable PhatSinhMaHD(string condition)
        {
            return KetNoi.GetDataTable("select * From HoaDonBanHang" + condition);
        }
        public void AddHoaDon(HoaDonBanHang ex)
        {
            const string sql = @"
                INSERT INTO HoaDonBanHang
                    (MaHDBH, MaKH, MaNV, NgayLapHDBH, TongTien, TrangThai)
                VALUES
                    (@MaHDBH, @MaKH, @MaNV, @NgayLap, @TongTien, @TrangThai)";

            try
            {
                KetNoi.OpenConnect();
                using (var cmd = new SqlCommand(sql, KetNoiDatabase.ConnectDB))
                {
                    cmd.Parameters.AddWithValue("@MaHDBH", ex.MaHDBH);
                    cmd.Parameters.AddWithValue("@MaKH", ex.MaKH);
                    cmd.Parameters.AddWithValue("@MaNV", ex.MaNV);
                    cmd.Parameters.AddWithValue("@NgayLap", ex.NgayLapHDBH);   
                    cmd.Parameters.AddWithValue("@TongTien", ex.TongTien);
                    cmd.Parameters.AddWithValue("@TrangThai", ex.TrangThai);

                    cmd.ExecuteNonQuery();
                }
            }
            finally
            {
                KetNoi.CloseConnect();
            }
        }


        public void AddCTHD(CT_HoaDonBanHang exx)
        {
            const string sql = @"
                INSERT INTO CT_HoaDonBanHang
                    (MaHDBH, MaLK, SoLuong, DonGia, KhuyenMai, ThanhTien, TrangThai)
                VALUES
                    (@MaHDBH, @MaLK, @SoLuong, @DonGia, @KhuyenMai, @ThanhTien, @TrangThai)";

            try
            {
                KetNoi.OpenConnect();
                using (var cmd = new SqlCommand(sql, KetNoiDatabase.ConnectDB))
                {
                    cmd.Parameters.AddWithValue("@MaHDBH", exx.MaHDBH);
                    cmd.Parameters.AddWithValue("@MaLK", exx.MaLK);
                    cmd.Parameters.AddWithValue("@SoLuong", exx.SoLuong);
                    cmd.Parameters.AddWithValue("@DonGia", exx.DonGia);
                    cmd.Parameters.AddWithValue("@KhuyenMai", exx.KhuyenMai);
                    cmd.Parameters.AddWithValue("@ThanhTien", exx.ThanhTien);
                    cmd.Parameters.AddWithValue("@TrangThai", exx.TrangThai);

                    cmd.ExecuteNonQuery();
                }
            }
            finally
            {
                KetNoi.CloseConnect();
            }
        }

        public void AddKH(KhachHang ex)
        {
            KetNoi.ExecuteReader(@"INSERT INTO KhachHang(MaKH,TenKH,GioiTinh,DienThoai,DiaChi,TrangThai)      
                                   VALUES(N'" + ex.MaKH + "',N'" + ex.TenKH + "',N'" + ex.GioiTinh +
                                    "',N'" + ex.DienThoai + "',N'" + ex.DiaChi + "',N'" + ex.TrangThai + "')");
        }
        public DataTable GetDSSP(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }

        public DataTable LaySP(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }

        public DataTable GetNhanVien(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }
        public DataTable GetDSkH(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }
        public DataTable GetTimKiem(string Condition)
        {
            return KetNoi.GetDataTable("" + Condition);
        }

        public DataTable GetHienThiDSSPTheoMa(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }

        public void UpdateSL(LinhKien lk)
        {
            KetNoi.ExecuteReader(@"Update LinhKien Set SoLuongTon=" + lk.SoLuongTon + " Where MaLK='" + lk.MaLK + "' ");
        }

        public void CapNhatSLTon(LinhKien lk)
        {
            KetNoi.ExecuteReader(@"Update LinhKien Set SoLuongTon=" + lk.SoLuongTon + " Where MalK=N'" + lk.MaLK + "'");
        }
    }
}
