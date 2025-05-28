# Computer parts store management program

ADMIN account: hoangminh, Password: hoangminh

Seller account: thaovan, Password: thaovan

Stock Receiving account: binhtinh, Password: binhtinh

### To run, run the sql script and edit this line of code in KetNoiDatabase.cs from:

``` KetNoiDatabase.ConnectDB = new SqlConnection(@"Data Source=TALIONN\SQLEXPRESS;Initial Catalog=PM_QLBanLinhKien_Laptop;Integrated Security=True;Encrypt=False"); ```

### to:

``` KetNoiDatabase.ConnectDB = new SqlConnection(@"Data Source=<<YOUR SSMS SERVER NAME>>;Initial Catalog=PM_QLBanLinhKien_Laptop;Integrated Security=True;Encrypt=False"); ```

## NOTE: after inputting account and password, please use your mouse to click the "Đăng nhập" button, pressing Enter won't register.
