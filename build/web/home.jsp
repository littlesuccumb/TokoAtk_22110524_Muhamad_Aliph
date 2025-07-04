<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tokoatk.UserDAO, tokoatk.BarangDAO, tokoatk.SalesDAO, tokoatk.StockDAO, tokoatk.LogDAO" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }

  String fullname = (String) session.getAttribute("fullname");

  int totalBarang = BarangDAO.count();
  int totalUser = UserDAO.count();
  int totalStock = StockDAO.getAll().size();
  int totalPenjualan = SalesDAO.getAll().size();

  java.util.Calendar now = java.util.Calendar.getInstance();
  int hour = now.get(java.util.Calendar.HOUR_OF_DAY);
  String sapaan = hour < 12 ? "pagi" : (hour < 15 ? "siang" : (hour < 18 ? "sore" : "malam"));

  List<String> recentSales = SalesDAO.getRecentSalesLog(3);
  List<String> recentStock = StockDAO.getRecentStockLog(3);

  List<String> logLogin = new ArrayList<>();
  List<String> logBarang = new ArrayList<>();
  for (String log : LogDAO.getLogTerbaru(3)) {
    if (log.contains("Login ke sistem")) {
      logLogin.add(log);
    } else if (log.contains("Menambahkan barang baru")) {
      logBarang.add(log);
    }
  }
%>
<%
  String pesan = request.getParameter("pesan");
  if ("login".equals(pesan)) {
%>
  <script>
    alert("Login berhasil! Selamat datang <%= session.getAttribute("fullname") %>");
  </script>
<%
  }
%>

<%@ include file="layout/layout.jsp" %>

<div class="content">
  <div class="container">
    <div class="dashboard-title">
      <h1>Dashboard</h1>
      <p>Selamat <%= sapaan %>, <strong><%= fullname %></strong> 👋</p>
      <p id="dashboard-time" style="color:#777;"></p>
    </div>

    <!-- Kartu Statistik -->
    <div class="dashboard-cards">
      <div class="card dashboard-card">
        <i class='bx bx-box icon'></i>
        <div class="card-info">
          <h2><%= totalBarang %></h2>
          <p>Total Barang</p>
        </div>
        <a href="barang/list.jsp" class="card-link-icon">
          <i class='bx bx-search-alt'></i> Lihat
        </a>
      </div>

      <div class="card dashboard-card">
        <i class='bx bx-user icon'></i>
        <div class="card-info">
          <h2><%= totalUser %></h2>
          <p>Total Pengguna</p>
        </div>
        <a href="users/list.jsp" class="card-link-icon">
          <i class='bx bx-search-alt'></i> Lihat
        </a>
      </div>

      <div class="card dashboard-card">
        <i class='bx bx-package icon'></i>
        <div class="card-info">
          <h2><%= totalStock %></h2>
          <p>Stok Masuk</p>
        </div>
        <a href="stock/list.jsp" class="card-link-icon">
          <i class='bx bx-search-alt'></i> Lihat
        </a>
      </div>

      <div class="card dashboard-card">
        <i class='bx bx-cart icon'></i>
        <div class="card-info">
          <h2><%= totalPenjualan %></h2>
          <p>Total Penjualan</p>
        </div>
        <a href="sales/list.jsp" class="card-link-icon">
          <i class='bx bx-search-alt'></i> Lihat
        </a>
      </div>
    </div>

    <!-- Grafik 2 kolom -->
    <div class="chart-grid">
      <div class="chart-box">
        <h2>Grafik Penjualan Harian</h2>
        <canvas id="salesChart"></canvas>
      </div>

      <div class="chart-box">
        <h2>Komposisi Jenis Barang Terjual</h2>
        <canvas id="donutChart"></canvas>
      </div>
    </div>

    <!-- Aktivitas Terbaru -->
    <div class="container" style="margin-top: 2rem;">
      <h2>Aktivitas Terbaru</h2>

      <!-- Penjualan -->
      <h4 class="log-label"><i class='bx bx-cart'></i> Transaksi Penjualan</h4>
      <ul class="recent-list styled-log">
        <% for (String log : recentSales) { %>
          <li>
            <div class="log-icon"><i class='bx bx-cart'></i></div>
            <div class="log-info"><%= log %></div>
          </li>
        <% } %>
      </ul>

      <!-- Stok Masuk -->
      <h4 class="log-label"><i class='bx bx-package'></i> Stok Masuk</h4>
      <ul class="recent-list styled-log">
        <% for (String log : recentStock) { %>
          <li>
            <div class="log-icon"><i class='bx bx-package'></i></div>
            <div class="log-info"><%= log %></div>
          </li>
        <% } %>
      </ul>

      <!-- Login Pengguna -->
      <h4 class="log-label"><i class='bx bx-user'></i> Login Pengguna</h4>
      <ul class="recent-list styled-log">
        <% for (String log : logLogin) { %>
          <li>
            <div class="log-icon"><i class='bx bx-user'></i></div>
            <div class="log-info"><%= log %></div>
          </li>
        <% } %>
      </ul>

      <!-- Tambah Barang -->
      <h4 class="log-label"><i class='bx bx-box'></i> Barang Ditambahkan</h4>
      <ul class="recent-list styled-log">
        <% for (String log : logBarang) { %>
          <li>
            <div class="log-icon"><i class='bx bx-box'></i></div>
            <div class="log-info"><%= log %></div>
          </li>
        <% } %>
      </ul>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
  function updateTime() {
    const el = document.getElementById("dashboard-time");
    const now = new Date();
    const days = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
    const day = days[now.getDay()];
    const date = now.toLocaleDateString('id-ID', { day: '2-digit', month: 'long', year: 'numeric' });
    const time = now.toLocaleTimeString('id-ID');
    el.textContent = `${day}, ${date} - ${time}`;
  }
  setInterval(updateTime, 1000);
  updateTime();

  fetch('chart-data')
    .then(res => res.json())
    .then(data => {
      const labels = Object.keys(data);
      const values = Object.values(data);

      new Chart(document.getElementById('salesChart'), {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: 'Jumlah Transaksi',
            data: values,
            backgroundColor: '#2d5a4a'
          }]
        },
        options: {
          responsive: true,
          plugins: {
            legend: { display: false },
            title: { display: true, text: 'Total Transaksi per Hari' }
          }
        }
      });
    });

  fetch('chart-jenis')
    .then(res => res.json())
    .then(data => {
      const labels = Object.keys(data);
      const values = Object.values(data);
      const backgroundColors = labels.map((_, i) => {
        const colors = ['#2d5a4a', '#4caf50', '#81c784', '#a5d6a7', '#c8e6c9', '#ffcc80', '#ffd54f', '#ffb74d', '#ff8a65', '#e57373', '#ba68c8', '#9575cd'];
        return colors[i % colors.length];
      });

      new Chart(document.getElementById('donutChart'), {
        type: 'doughnut',
        data: {
          labels: labels,
          datasets: [{
            label: 'Jenis Barang',
            data: values,
            backgroundColor: backgroundColors
          }]
        },
        options: {
          responsive: true,
          plugins: {
            title: {
              display: true,
              text: 'Distribusi Jenis Barang Terjual'
            },
            legend: {
              position: 'right',
              labels: {
                color: '#444'
              }
            }
          }
        }
      });
    });
</script>
