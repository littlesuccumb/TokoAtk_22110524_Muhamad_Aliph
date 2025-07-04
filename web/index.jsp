<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Toko ATK | Littlesuccumb</title>
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-icons@1.13.12/iconfont/material-icons.min.css">
</head>
<body>
<body>
<%
  String pesan = request.getParameter("pesan");
  if ("belumlogin".equals(pesan)) {
%>
  <script>alert("Anda harus login terlebih dahulu.");</script>
<%
  } else if ("logout".equals(pesan)) {
%>
  <script>alert("Anda berhasil logout.");</script>
<%
  } else if ("gagal".equals(pesan)) {
%>
  <script>alert("Login gagal! Username atau password salah.");</script>
<%
  }

  String register = request.getParameter("register");
  if ("success".equals(register)) {
%>
  <script>
    alert("Registrasi berhasil! Silakan login.");
    window.addEventListener("DOMContentLoaded", () => {
      document.getElementById("reg-log").checked = false;
    });
  </script>
<%
  } else if ("gagal".equals(register)) {
%>
  <script>alert("Registrasi gagal! Terjadi kesalahan.");</script>
<%
  } else if ("duplikat".equals(register)) {
%>
  <script>alert("Username sudah digunakan!");</script>
<%
  } else if ("kosong".equals(register)) {
%>
  <script>alert("Semua field harus diisi.");</script>
<%
  }
%>


    <nav class="navbar">
        <div class="container">
            <div class="row justify-content-between align-items-center">
                <div class="logo">Little<span>succumb</span></div>
                <input type="checkbox" id="click">
                <label for="click" class="menu-btn">
                    <i class="material-icons">menu</i>
                </label>
                <ul>
                    <li><a href="#" class="active">Home</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#gallery">Gallery</a></li>
                    <li><a href="#feedback">Feedback</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <section>
        <div class="container">
            <div class="row full-screen align-items-center">
                <div class="left">
                    <span class="line"></span>
                    <h2>Hello, I'm Muhamad Aliph, <br> a <span>digital designer</span></h2>
                    <p>Selamat datang di Website Toko ATK</p>
                    <a href="#feedback" class="btn">Contact</a>

                    <div class="social-media">
                        <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                        <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                        <a href="#"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#"><i class="fa-brands fa-youtube"></i></a>
                        <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="right">
                    <div class="form">
                        <div class="text-center">
                            <h6><span>Log In</span> <span>Sign Up</span></h6>
                            <input type="checkbox" class="checkbox" id="reg-log">
                            <label for="reg-log"></label>
                            <div class="card-3d-wrap">
                                <div class="card-3d-wrapper">

                                    <!-- LOGIN -->
                                    <div class="card-front">
                                        <div class="center-wrap">
                                            <h4 class="heading">Log In</h4>
                                            <form action="users/prosesLogin.jsp" method="post">
                                                <div class="form-group">
                                                    <input type="text" name="username" class="form-style" placeholder="Your Username" required autocomplete="off">
                                                    <i class="input-icon material-icons">alternate_email</i>
                                                </div>

                                                <div class="form-group">
                                                    <input type="password" name="password" class="form-style" placeholder="Your Password" required autocomplete="off">
                                                    <i class="input-icon material-icons">lock</i>
                                                </div>

                                                <button type="submit" class="btn">Login</button>
                                            </form>
                                            <p class="text-center"><a href="#" class="link">Forgot your password?</a></p>
                                        </div>
                                    </div>

                                    <!-- REGISTER -->
                                    <div class="card-back">
                                        <div class="center-wrap">
                                            <h4 class="heading">Sign Up</h4>
                                            <form action="users/tambah" method="post">
                                                <div class="form-group">
                                                    <input type="text" name="username" class="form-style" placeholder="Your Username" required autocomplete="off">
                                                    <i class="input-icon material-icons">perm_identity</i>
                                                </div>

                                                <div class="form-group">
                                                    <input type="text" name="fullname" class="form-style" placeholder="Your Full Name" required autocomplete="off">
                                                    <i class="input-icon material-icons">badge</i>
                                                </div>

                                                <div class="form-group">
                                                    <input type="password" name="password" class="form-style" placeholder="Your Password" required autocomplete="off">
                                                    <i class="input-icon material-icons">lock</i>
                                                </div>

                                                <button type="submit" class="btn">Register</button>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>    
                </div>
            </div>
        </div>

        <!-- Sections: About, Services, Gallery, Feedback -->
        <section id="about" class="content-section">
            <div class="container">
                <h2 class="section-title">About Us</h2>
                <p class="section-desc">Toko ATK adalah sistem manajemen toko alat tulis berbasis web yang dirancang untuk mempermudah pencatatan barang, stok masuk, dan transaksi penjualan secara efisien dan modern.</p>
            </div>
        </section>

<section id="services" class="content-section">
    <div class="container">
        <h2 class="section-title">Our Services</h2>
        <div class="services-grid">
            <div class="service-card">
                <i class="fa-solid fa-boxes-stacked service-icon"></i>
                <h3>Manajemen Barang</h3>
                <p>Mengelola data barang secara rapi dan efisien untuk kebutuhan stok toko Anda.</p>
            </div>
            <div class="service-card">
                <i class="fa-solid fa-cart-shopping service-icon"></i>
                <h3>Transaksi Penjualan</h3>
                <p>Mencatat penjualan barang dengan detail dan akurat, serta laporan yang mudah dipantau.</p>
            </div>
            <div class="service-card">
                <i class="fa-solid fa-arrow-down-wide-short service-icon"></i>
                <h3>Stok Masuk</h3>
                <p>Mencatat dan memantau semua barang masuk agar stok selalu terupdate secara real-time.</p>
            </div>
            <div class="service-card">
                <i class="fa-solid fa-users-gear service-icon"></i>
                <h3>Pengelolaan Pengguna</h3>
                <p>Kelola data pengguna dan petugas toko dengan hak akses yang sesuai dan aman.</p>
            </div>
        </div>
    </div>
</section>


        <section id="gallery" class="gallery-section">
            <div class="container">
                <h2 class="section-title">Gallery</h2>
                <div class="gallery-grid">
                    <div class="gallery-item"><img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="Gallery Image 1"></div>
                    <div class="gallery-item"><img src="https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80" alt="Gallery Image 2"></div>
                    <div class="gallery-item"><img src="https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=400&q=80" alt="Gallery Image 3"></div>
                    <div class="gallery-item"><img src="https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80" alt="Gallery Image 4"></div>
                </div>
            </div>
        </section>

        <section id="feedback" class="content-section">
            <div class="container">
                <h2 class="section-title">Feedback</h2>
                <form class="feedback-form" action="#" method="post">
                    <input type="text" name="name" placeholder="Your Name" required autocomplete="off">
                    <input type="email" name="email" placeholder="Your Email" required autocomplete="off">
                    <textarea name="message" placeholder="Your Feedback" required></textarea>
                    <button type="submit" class="btn">Send Feedback</button>
                </form>
            </div>
        </section>
    </section>
</body>
</html>
