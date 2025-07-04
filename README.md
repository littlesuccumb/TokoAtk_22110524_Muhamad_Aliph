# 🛒 Aplikasi Web Toko ATK - JSP & Servlet

Proyek ini merupakan aplikasi web manajemen Toko ATK berbasis **Java Web (JSP & Servlet)** dengan fitur CRUD, login user, serta tampilan data penjualan, stok, dan barang. Dibuat dengan pola **MVC (Model-View-Controller)** menggunakan **NetBeans** dan **Tomcat**.

---

## 👤 Identitas Mahasiswa

- **Nama:** Muhamad Aliph Fauzansyah  
- **NIM:** 22110524  
- **Kelas:** L2022  
- **Mata Kuliah:** Pemrograman Java Lanjut

---

## 🚀 Fitur Utama

- 🔐 Login & Logout user
- 👤 Manajemen User
- 📦 CRUD Barang
- 📊 CRUD Penjualan (Sales)
- 🏷️ CRUD Stok
- 📈 Statistik Penjualan via Chart
- 💅 Styling dengan CSS dan JavaScript

---

## 🛠 Teknologi

- Java Server Pages (JSP)
- Jakarta Servlet
- MVC Pattern
- HTML, CSS, JavaScript
- Servlet API & Gson

---

## 📂 Struktur Folder Utama

### Web Pages
```
Web Pages/
├── api/
│   ├── barang/
│   │   ├── gantinama.jsp, hapus.jsp, stat.jsp, tambah.jsp
│   └── sales/total.jsp
├── barang/, sales/, stock/
│   ├── detail.jsp, form.jsp, hapus.jsp, list.jsp
├── layout/layout.jsp
├── css/style.css, login.css
├── js/script.js
├── users/form.jsp, list.jsp, prosesLogin.jsp
├── home.jsp, index.jsp, logout.jsp
```

### Source Packages
```
controller/
├── barang/: EditBarangServlet, TambahBarangServlet, HapusBarangServlet
├── sales/: TambahSalesServlet, HapusSalesServlet
├── stock/: TambahStockServlet, HapusStockServlet
├── users/: TambahUserServlet, HapusUserServlet, UpdateUserServlet
├── home/: ChartDataServlet, ChartJenisServlet

model/
├── Barang, Sales, SalesDetail, Stock, StockDetail, User

tokoatk/
├── DAO: BarangDAO, SalesDAO, StockDAO, StockDetailDAO, SalesDetailDAO, UserDAO
├── LogDAO, DbConnection
```

---

## ⚙️ Cara Menjalankan

1. Buka project di **NetBeans**
2. Pastikan **Tomcat / GlassFish** sudah terpasang
3. Jalankan project dan buka:
```
http://localhost:8080/TokoAtkWeb/
```

---

## 📌 Catatan

- Proyek ini memiliki struktur rapi dan mengikuti pola MVC
- Semua proses login dan manajemen data di-handle melalui Servlet + JSP
- Tersedia folder `api/` untuk endpoint JSP tambahan seperti statistik & AJAX

---

## 📬 Kontak

- GitHub: [@littlesuccumb](https://github.com/littlesuccumb)

---

> Proyek ini dibuat sebagai pemenuhan tugas mata kuliah **Pemrograman Java Lanjut**  
> Jangan lupa ngopi, push, submit, dan tidur 😴🔥
