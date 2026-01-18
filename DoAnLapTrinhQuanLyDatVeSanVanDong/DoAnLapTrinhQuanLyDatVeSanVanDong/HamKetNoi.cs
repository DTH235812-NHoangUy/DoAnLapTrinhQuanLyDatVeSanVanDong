using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace QuanLyBenhNhan
{
    internal class HamKetNoi
    {
        // Khai báo đối tượng kết nối dùng chung
        public static SqlConnection Con;

        public static void Connect()
        {
            // Nên dùng try-catch để tránh crash khi không kết nối được
            try
            {
                string connectionString = @"admin\SQLEXPRESS01;Initial Catalog=QuanLySanVanDong;Integrated Security=True";
                Con = new SqlConnection(connectionString);

                if (Con.State != ConnectionState.Open)
                {
                    Con.Open();
                    MessageBox.Show("Kết nối cơ sở dữ liệu thành công.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Không thể kết nối với dữ liệu: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public static void Disconnect()
        {
            if (Con != null && Con.State == ConnectionState.Open)
            {
                Con.Close();
                Con.Dispose();
                Con = null;
                MessageBox.Show("Đã ngắt kết nối.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public static DataTable GetDataToTable(string sql)
        {
            DataTable table = new DataTable();
            try
            {
                SqlDataAdapter dap = new SqlDataAdapter(sql, Con);
                dap.Fill(table);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return table;
        }

        public static bool CheckKey(string sql)
        {
            SqlDataAdapter dap = new SqlDataAdapter(sql, Con);
            DataTable table = new DataTable();
            dap.Fill(table);
            return table.Rows.Count > 0;
        }

        public static void RunSQL(string sql)
        {
            using (SqlCommand cmd = new SqlCommand(sql, Con))
            {
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }
            }
        }

        public static string GetFieldValues(string sql)
        {
            string result = "";
            using (SqlCommand cmd = new SqlCommand(sql, Con))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                        result = reader[0].ToString();
                }
            }
            return result;
        }

        public static void FillCombo(string sql, ComboBox cbo, string ma, string ten)
        {
            SqlDataAdapter dap = new SqlDataAdapter(sql, Con);
            DataTable table = new DataTable();
            dap.Fill(table);
            cbo.DataSource = table;
            cbo.ValueMember = ma;   // Trường giá trị (thường là mã)
            cbo.DisplayMember = ten; // Trường hiển thị (thường là tên)
        }
    }
}