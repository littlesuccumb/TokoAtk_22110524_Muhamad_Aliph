<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String menu = request.getParameter("menu");
    if (menu == null) menu = "";
    String username = (String) session.getAttribute("user");
    String initial = "?";
    if (session.getAttribute("fullname") != null) {
        String fname = ((String) session.getAttribute("fullname")).trim();
        if (!fname.isEmpty()) {
            initial = fname.substring(0, 1).toUpperCase();
        }
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Toko ATK</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar" id="sidebar">
  <div class="sidebar-header">
    <i class='bx bxs-store'></i>
    <span class="app-title">Toko ATK</span>
  </div>
<ul class="menu-links">
  <li><a href="<%= request.getContextPath() %>/home.jsp?menu=dashboard" class='<%= "dashboard".equals(menu) ? "active" : "" %>'><i class='bx bx-home'></i> <span>Dashboard</span></a></li>
  <li><a href="<%= request.getContextPath() %>/barang/list.jsp?menu=barang" class='<%= "barang".equals(menu) ? "active" : "" %>'><i class='bx bx-box'></i> <span>Barang</span></a></li>
  <li><a href="<%= request.getContextPath() %>/users/list.jsp?menu=user" class='<%= "user".equals(menu) ? "active" : "" %>'><i class='bx bx-user'></i> <span>User</span></a></li>
  <li><a href="<%= request.getContextPath() %>/sales/list.jsp?menu=sales" class='<%= "sales".equals(menu) ? "active" : "" %>'><i class='bx bx-cart'></i> <span>Transaksi</span></a></li>
  <li><a href="<%= request.getContextPath() %>/stock/list.jsp?menu=stock" class='<%= "stock".equals(menu) ? "active" : "" %>'><i class='bx bx-package'></i> <span>Stok Masuk</span></a></li>
</ul>
<ul class="logout-link">
  <li><a href="<%= request.getContextPath() %>/logout.jsp"><i class='bx bx-log-out'></i> <span>Logout</span></a></li>
</ul>
</div>

<!-- NAVBAR -->
<div class="navbar">
  <button class="toggle-btn" onclick="toggleSidebar()"><i class='bx bx-menu'></i></button>
  <div class="navbar-center">
    <div id="clock" class="realtime-clock"><span id="clock-time"></span></div>
  </div>
  <div class="navbar-right">
    <button class="dark-btn" id="darkModeToggle"><i class='bx bx-moon'></i></button>
    <div class="user-dropdown" onclick="this.classList.toggle('active')">
      <div class="user-avatar"><%= initial %></div>
      <div class="dropdown-menu">
        <a href="#">My Profile</a>
        <a href="<%= request.getContextPath() %>/users/form.jsp?username=<%= username %>">Settings</a>
        <a href="<%= request.getContextPath() %>/logout.jsp">Log Out</a>
      </div>
    </div>
  </div>
</div>

<!-- JS -->
<script src="<%= request.getContextPath() %>/js/script.js"></script>

<script>
      document.getElementById("darkModeToggle").addEventListener("click", function () {
    document.body.classList.toggle("dark-mode");
    const icon = this.querySelector("i");
    icon.classList.toggle("bx-moon");
    icon.classList.toggle("bx-sun");
  });
  // Cek preferensi dark mode saat halaman dimuat
  if (localStorage.getItem("dark-mode") === "true") {
    document.body.classList.add("dark-mode");
    const icon = document.getElementById("darkModeToggle").querySelector("i");
    icon.classList.remove("bx-moon");
    icon.classList.add("bx-sun");
  }

  // Toggle dark mode
  document.getElementById("darkModeToggle").addEventListener("click", function () {
    const icon = this.querySelector("i");
    const isDark = document.body.classList.toggle("dark-mode");
    localStorage.setItem("dark-mode", isDark); // Simpan preferensi
    icon.classList.toggle("bx-moon");
    icon.classList.toggle("bx-sun");
  });
</script>
