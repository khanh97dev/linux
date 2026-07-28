# Linux

## Terminal remove
```sh
sudo apt-get remove --purge mysql*
sudo apt-get purge mysql*
sudo apt-get autoremove.
sudo apt-get autoclean.
sudo apt-get remove dbconfig-mysql.
sudo apt-get dist-upgrade.
sudo apt-get install mysql-server.
```
## TaskBar 
```sh
sudo apt install plank
plank --preferences 
```
---

### 1.Run Photoshop.exe
```sh
sudo apt-get install wine-development
wine 'runFile.exe'
```

### 2.Mysql 
```sh
sudo apt install mysql-server
sudo mysql_secure_installation
sudo mysql -u root

mysql> USE mysql;
mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='root';
mysql> FLUSH PRIVILEGES;
mysql> exit;
```

---

# Mimo Setup - Cài đặt cấu hình MimoCode

Script tự động tạo và cập nhật file cấu hình cho MimoCode CLI với các provider Claude và Qwen.

## Yêu cầu hệ thống

- Linux/Unix environment
- `sudo` quyền truy cập
- curl (để cài đặt từ remote)

## Cài đặt nhanh

### Cách 1: Cài đặt từ remote (khuyến nghị)

```bash
# Chạy trực tiếp từ GitHub
curl -fsSL https://raw.githubusercontent.com/khanh97dev/linux/master/mimo.sh | sh
```

Script sẽ tự động yêu cầu quyền root nếu cần.

### Cách 2: Chạy trực tiếp từ thư mục hiện tại

```bash
# Cấp quyền thực thi
chmod +x mimo.sh

# Chạy script
./mimo.sh
```

### Cách 3: Copy vào hệ thống

```bash
# Copy script vào /usr/local/bin
sudo cp mimo.sh /usr/local/bin/mimo-update
sudo chmod +x /usr/local/bin/mimo-update

# Sử dụng từ bất kỳ đâu
sudo mimo-update
```

## Cấu hình mặc định

Script sẽ tạo file cấu hình tại `/root/.config/mimocode/mimocode.jsonc` với:

### Instructions
- Luôn trả lời bằng tiếng Việt
- Giữ nguyên tiếng Anh cho: source code, comment, log, error message, lệnh terminal, tên biến/hàm/file, commit message
- Không dịch thuật ngữ kỹ thuật
- Trả lời ngắn gọn, đi thẳng vào vấn đề

### Providers

#### Claude Provider
- **Base URL**: `http://localhost:11234/v1`
- **API Key**: `Work1234` (có thể thay đổi trong script)
- **Models hỗ trợ**:
  - `opus`
  - `haiku`
  - `sonnet`

#### Qwen Provider
- **Name**: Qwen Local
- **Base URL**: `http://172.25.57.241:9090/v1`
- **Models hỗ trợ**:
  - `qwen36-35b` (maxInputTokens: 92160, maxOutputTokens: 8192)

## Tùy chỉnh cấu hình

### Thay đổi API Key

Mở file `mimo.sh` và sửa dòng:
```bash
CLAUDE_API_KEY=Work1234
```
thành key của bạn.

### Thay đổi Base URL

Sửa các dòng trong file script:
```bash
"baseURL": "http://localhost:11234/v1"
"baseURL": "http://172.25.57.241:9090/v1"
```
theo địa chỉ server của bạn.

## Xác nhận cài đặt

Sau khi chạy script, kiểm tra file cấu hình:

```bash
cat /root/.config/mimocode/mimocode.jsonc
```

Hoặc sử dụng MimoCode CLI để test:

```bash
mimo --help
mimo chat "Xin chào"
```

## Gỡ bỏ

```bash
# Xóa file cấu hình
sudo rm -rf /root/.config/mimocode

# Xóa script (nếu đã copy vào hệ thống)
sudo rm /usr/local/bin/mimo-update
```

## Xử lý sự cố

### Lỗi phân quyền
Đảm bảo chạy script với `sudo`:
```bash
sudo ./mimo.sh
```

### Kiểm tra JSON hợp lệ
```bash
# Cài đặt jq nếu chưa có
sudo apt install jq

# Validate JSON
jq . /root/.config/mimocode/mimocode.jsonc
```
