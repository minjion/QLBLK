using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BUS;
using DTO;
using Microsoft.Office.Interop.Excel;
namespace DoAnCShap
{
    public partial class Frm_NhaSanXuat : Form
    {
        public Frm_NhaSanXuat()
        {
            InitializeComponent();
        }
        NhaSanXuat_BUS bus = new NhaSanXuat_BUS();
        NhaSanXuat nsx = new NhaSanXuat();
        int flag = 0;
        public void DisPlay()
        {
            dataGridViewNSX.DataSource = bus.GetData("");
        }

        public void HienThiSearch(string Condition)
        {
            dataGridViewNSX.DataSource = bus.GetTimKiem("Select * From NhaSanXuat Where TenNSX Like N'%"+Condition+"%'");
        }
        public void xulytextbox(Boolean b1, Boolean b2)
        {
            txtMaNSX.Enabled = b1;
            txtTenNSX.Enabled = b1;
            txtDiaChi.Enabled = b1;
            cboTrangThai.Enabled = b1;
        }

        public void xulychucnang(Boolean b1, Boolean b2, Boolean b3)
        {
            btnThem.Enabled = b1;
            btnXoa.Enabled = b3;
            btnLuu.Enabled = b2;
            btnHuy.Enabled = b2;
        }

        public void Clear()
        {
            txtMaNSX.Clear();
            txtTenNSX.Clear();
            txtDiaChi.Clear();
            cboTrangThai.Text = "";
            
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            flag = 1;
            xulychucnang(false,true,true);
            xulytextbox(true, false);
            cboTrangThai.Enabled = false; // không được sửa khi thêm nsx
            PhatSinhMa();
        }


        public void PhatSinhMa()
        {
            int count = 0;
            count = dataGridViewNSX.Rows.Count;
            string chuoi = "";
            int chuoi2 = 0;
            if (count <= 1)
            {
                txtMaNSX.Text = "NSX01";
            }
            else
            {
                chuoi = Convert.ToString(dataGridViewNSX.Rows[count - 2].Cells[0].Value);
                chuoi2 = Convert.ToInt32((chuoi.Remove(0, 3)));
                if (chuoi2 + 1 < 10)
                    txtMaNSX.Text = "NSX0" + (chuoi2 + 1).ToString();
                else if (chuoi2 + 1 < 100)
                    txtMaNSX.Text = "NSX" + (chuoi2 + 1).ToString();
            }
        }
        private void Frm_NSX_Load(object sender, EventArgs e)
        {
            DisPlay();
            xulychucnang(true, false, false);
            xulytextbox(false, true);
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (flag == 1)
            {
                if (txtMaNSX.Text != "" && txtTenNSX.Text != "" && txtDiaChi.Text != "")
                {
                    nsx.MaNSX = txtMaNSX.Text;
                    nsx.TenNSX = txtTenNSX.Text;
                    nsx.DiaChi = txtDiaChi.Text;

                    nsx.TrangThai = "1";
                    bus.AddData(nsx);
                    MessageBox.Show("Thêm nhà sản xuất thành công");
                    Clear();
                    xulychucnang(true, false, false);
                    xulytextbox(false, true);
                }
                else
                {
                    MessageBox.Show("Fail! Vui lòng điền đầy đủ thông tin");
                }

            }
            if (flag != 1)
            {
                if (txtMaNSX.Text == "")
                {
                    errorMes.BlinkRate = 100;
                    errorMes.SetError(txtMaNSX, "? MaNSX");
                    return;
                }
                if (txtTenNSX.Text == "")
                {
                    errorMes.BlinkRate = 100;
                    errorMes.SetError(txtTenNSX, "? TenNSX");
                    return;
                }
                if (txtDiaChi.Text == "")
                {
                    errorMes.BlinkRate = 100;
                    errorMes.SetError(txtDiaChi, "? Địa chỉ");
                    return;
                }
                else
                {
                    nsx.MaNSX = txtMaNSX.Text;
                    int vitri = dataGridViewNSX.CurrentCell.RowIndex;
                    if (dataGridViewNSX.Rows.Count > 0)
                    {
                        if (txtTenNSX.Text.ToLower() == dataGridViewNSX.Rows[vitri].Cells["TenNSX"].Value.ToString().ToLower())
                        {
                            // Bỏ Qua
                        }
                        else
                        {
                            for (int i = 0; i < dataGridViewNSX.Rows.Count; i++)
                            {
                                if (dataGridViewNSX.Rows[i].IsNewRow) continue; 

                                object cellValue = dataGridViewNSX.Rows[i].Cells["TenNSX"].Value;
                                if (cellValue != null && txtTenNSX.Text.ToLower() == cellValue.ToString().ToLower())
                                {
                                    errorMes.BlinkRate = 100;
                                    errorMes.SetError(txtTenNSX, "Đã tồn tại");
                                    return;
                                }
                            }

                        }
                    }
                    nsx.MaNSX = txtMaNSX.Text;
                    nsx.TenNSX = txtTenNSX.Text;
                    nsx.DiaChi = txtDiaChi.Text;
                    if (cboTrangThai.SelectedItem != null && cboTrangThai.SelectedItem.ToString() == "Active")
                    {
                        nsx.TrangThai = "1";
                    }
                    else
                    {
                        nsx.TrangThai = "0";
                    }
                    bus.EditData(nsx);
                    MessageBox.Show("Cập nhật nhà sản xuất thành công");
                    Clear();
                    xulychucnang(true, false, false);
                    xulytextbox(true, true);
                }
      
            }
            DisPlay();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dataGridViewNSX_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridViewRow row = dataGridViewNSX.Rows[e.RowIndex];
            txtMaNSX.Text = row.Cells[0].Value.ToString();
            txtTenNSX.Text = row.Cells[1].Value.ToString();
            txtDiaChi.Text = row.Cells[2].Value.ToString();
            //cboTrangThai.Text = row.Cells[3].Value.ToString();
            xulychucnang(true, true, true);
            xulytextbox(true, true);
        }

        private void dataGridViewNSX_DoubleClick(object sender, EventArgs e)
        {
            flag = 2;
            xulychucnang(false, true, true);
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
          
            try
            {
                if (txtMaNSX.Text == "")
                {
                    MessageBox.Show("Vui lòng chọn Nhà Sản Xuất cần xóa", "Thông báo !");
                    return;
                }
                nsx.MaNSX = txtMaNSX.Text;
                bus.DeleteData(nsx);
                Clear();
                DisPlay();
                MessageBox.Show("Đã xóa thành công");

            }
            catch
            {
                MessageBox.Show("Không thể xóa. Vui lòng kiểm tra lại!");
            }
        }

        private void txtSearch_TextChanged(object sender, EventArgs e)
        {
            String Condition = txtSearch.Text;
            HienThiSearch(Condition);
        }

        private void txtMaNSX_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            DialogResult KQ = MessageBox.Show("Bạn có muốn hủy hay không ?", "Thông Báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
            if (KQ == DialogResult.OK)
            {
                xulychucnang(true, false, false);
                Clear();
            }
        }
    }
}
