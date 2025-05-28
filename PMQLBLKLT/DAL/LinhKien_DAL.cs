using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
    public class LinhKien_DAL
    {
        KetNoiDatabase KetNoi = new KetNoiDatabase();
        //  LẤY DỮ LIỆU
        public DataTable GetData(string Condition)
        {
            //return KetNoi.GetDataTable("select MaLK,LoaiLinhKien.TenLLK,NhaCungCap.TenNCC,TenLK,BaoHanh,XuatXu,TinhTrang,DonViTinh,DonGia,SoLuongTon,KhuyenMai,HinhAnh from LinhKien, NhaCungCap,LoaiLinhKien Where NhaCungCap.MaNCC=LinhKien.MaNCC and LoaiLinhKien.MaLLK=LinhKien.MaLLK and LinhKien.TrangThai=N'1' Order By TenLK ASC " + Condition);

            return KetNoi.GetDataTable("select MaLK,LoaiLinhKien.TenLLK,NhaCungCap.TenNCC,NhaSanXuat.TenNSX,TenLK,BaoHanh,XuatXu,TinhTrang,DonViTinh,DonGia,SoLuongTon,KhuyenMai,HinhAnh from LinhKien, NhaCungCap,LoaiLinhKien, NhaSanXuat Where NhaSanXuat.MaNSX=LinhKien.MaNSX and NhaCungCap.MaNCC=LinhKien.MaNCC and LoaiLinhKien.MaLLK=LinhKien.MaLLK and LinhKien.TrangThai=N'1' Order By TenLK ASC " + Condition);

        }
        public DataTable PhatSinMa(string condition)
        {
            return KetNoi.GetDataTable("Select * From LinhKien " + condition);
        }
        public DataTable KiemTraDuLieu(string condition)
        {
            return KetNoi.GetDataTable("" + condition);
        }
        //TÌM KIẾM
        public DataTable GetSearch(string Condition)
        {
            return KetNoi.GetDataTable("select MaLK,LoaiLinhKien.TenLLK,NhaCungCap.TenNCC,NhaSanXuat.TenNSX,TenLK,BaoHanh,XuatXu,TinhTrang,DonViTinh,DonGia,SoLuongTon,KhuyenMai,HinhAnh from LinhKien, NhaCungCap,NhaSanXuat,LoaiLinhKien Where NhaCungCap.MaNCC=LinhKien.MaNCC and NhaSanXuat.MaNSX=LinhKien.MaNSX and LoaiLinhKien.MaLLK=LinhKien.MaLLK and LinhKien.TrangThai=N'1' and (TenLK like N'%" + Condition + "%' or MaLK Like N'%" + Condition + "%')");
        }
        // THÊM DỮ LIỆU
        public void AddData(LinhKien ex)
        {
            KetNoi.ExecuteReader(@"Insert INTO LinhKien(MaLK,MaLLK,MaNCC,MaNSX,TenLK,BaoHanh,XuatXu,TinhTrang,DonViTinh,DonGia,SoLuongTon,KhuyenMai,HinhAnh,TrangThai) VALUES(N'" + ex.MaLK + "',N'" + ex.MaLLK + "',N'" + ex.MaNCC + "',N'" + ex.MaNSX + "',N'" + ex.TenLK + "',N'" + ex.BaoHanh + "',N'" + ex.XuatXu + "',N'" + ex.TinhTrang + "',N'" + ex.DonViTinh + "'," + ex.DonGia + "," + ex.SoLuongTon + "," + ex.KhuyenMai + ",N'" + ex.HinhAnh + "',N'" + ex.TrangThai + "')");
        }
        //  SỬA DỮ LIỆU
        public void EditData(LinhKien ex)
        {
            KetNoi.ExecuteReader(@"Update LinhKien SET MaLLk=N'" + ex.MaLLK + "',MaNCC=N'" + ex.MaNCC + "',MaNSX=N'" + ex.MaNSX + "',TenLK=N'" + ex.TenLK + "',BaoHanh=N'" + ex.BaoHanh + "',XuatXu=N'" + ex.XuatXu + "',TinhTrang=N'" + ex.TinhTrang + "',DonViTinh=N'" + ex.DonViTinh + "',DonGia=" + ex.DonGia + ",SoLuongTon=" + ex.SoLuongTon + ",KhuyenMai=" + ex.KhuyenMai + ",HinhAnh=N'" + ex.HinhAnh + "',TrangThai=N'" + ex.TrangThai + "' Where MaLK=N'" + ex.MaLK + "'");
        }
        //  XÓA DỮ LIỆU
        public void DeleteData(LinhKien ex)
        {
            KetNoi.ExecuteReader(@"Update LinhKien Set TrangThai=N'0' Where MaLK=N'" + ex.MaLK + "'");
        }
        public DataTable GetByNCCAndNSX(string maNCC, string maNSX)
        {
            string sql = @"
            SELECT MaLK,
                   LoaiLinhKien.TenLLK,
                   NhaCungCap.TenNCC,
                   NhaSanXuat.TenNSX,
                   TenLK,
                   BaoHanh,
                   XuatXu,
                   TinhTrang,
                   DonViTinh,
                   DonGia,
                   SoLuongTon,
                   KhuyenMai,
                   HinhAnh
            FROM LinhKien
            JOIN NhaCungCap     ON NhaCungCap.MaNCC    = LinhKien.MaNCC
            JOIN NhaSanXuat    ON NhaSanXuat.MaNSX    = LinhKien.MaNSX
            JOIN LoaiLinhKien  ON LoaiLinhKien.MaLLK  = LinhKien.MaLLK
            WHERE LinhKien.TrangThai = N'1'
              AND LinhKien.MaNCC     = N'" + maNCC + @"'
              AND LinhKien.MaNSX     = N'" + maNSX + @"'
            ORDER BY TenLK ASC";

            return KetNoi.GetDataTable(sql);
        }
    }
}
