<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Barang, java.util.List" %>
<%@ page import="tokoatk.BarangDAO" %>
<%@ include file="../layout/layout.jsp" %>

<div class="content">
  <div class="container">

    <%-- Notifikasi berdasarkan status --%>
    <%
      String status = request.getParameter("status");
      if ("tambah".equals(status)) {
    %>
      <div class="notif success"><i class='bx bx-check-circle'></i> Barang berhasil ditambahkan.</div>
    <%
      } else if ("hapus".equals(status)) {
    %>
      <div class="notif success"><i class='bx bx-check-circle'></i> Barang berhasil dihapus.</div>
    <%
      } else if ("ubah".equals(status)) {
    %>
      <div class="notif success"><i class='bx bx-check-circle'></i> Barang berhasil diperbarui.</div>
    <%
      } else if ("gagal".equals(status)) {
    %>
      <div class="notif error"><i class='bx bx-error-circle'></i> Gagal memproses data.</div>
    <%
      }
    %>

    <div class="dashboard-title">
      <h1><i class='bx bx-box'></i> Data Barang</h1>
      <div style="display: flex; gap: 10px;">
        <a href="form.jsp" class="btn tambah"><i class='bx bx-plus'></i> Tambah Barang</a>
        <a href="#" class="btn tambah" onclick="tambahBarangApi()"><i class='bx bx-bolt-circle'></i> Tambah via API</a>
        <a href="#" class="btn tambah" onclick="tampilkanStatApi()"><i class='bx bx-bar-chart'></i> Statistik</a>
      </div>
    </div>

    <div class="search-wrapper">
      <div class="search-box">
        <i class='bx bx-search'></i>
        <input type="text" id="searchInput" placeholder="Cari nama atau jenis barang..." />
      </div>
    </div>

    <div class="table-wrapper">
      <table id="barangTable">
        <thead>
          <tr>
            <th onclick="sortTable(0)">ID</th>
            <th onclick="sortTable(1)">Nama</th>
            <th onclick="sortTable(2)">Jenis</th>
            <th onclick="sortTable(3)">Harga</th>
            <th>Aksi</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Barang> daftar = BarangDAO.getAll();
            for (Barang b : daftar) {
              String hargaRp = "Rp " + String.format("%,d", b.getHarga()).replace(",", ".");
          %>
          <tr>
            <td><%= b.getId() %></td>
            <td id="nama<%= b.getId() %>"><%= b.getNama() %></td>
            <td><%= b.getJenis() %></td>
            <td><%= hargaRp %></td>
            <td>
              <a href="#" class="btn icon-only" onclick="showDetail('<%= b.getId() %>')"><i class='bx bx-info-circle'></i></a>
              <a href="form.jsp?id=<%= b.getId() %>" class="btn icon-only"><i class='bx bx-edit'></i></a>
              <a href="#" class="btn icon-only" onclick="hapusBarangApi('<%= b.getId() %>')"><i class='bx bx-trash'></i></a>
              <a href="#" class="btn icon-only" onclick="gantiNamaApi('<%= b.getId() %>')"><i class='bx bx-rename'></i></a>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal-overlay" id="modalBox" style="display:none;">
  <div class="modal-card">
    <div class="modal-header">
      <h2 id="modalTitle">Modal</h2>
      <button class="btn-close" onclick="closeModal()">&times;</button>
    </div>
    <div class="modal-body" id="modalContent">
      <!-- konten dinamis -->
    </div>
    <div class="modal-footer" id="modalFooter">
      <!-- tombol aksi -->
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
  function showDetail(id) {
    fetch('detail.jsp?id=' + id)
      .then(res => res.text())
      .then(html => {
        const container = document.createElement('div');
        container.innerHTML = html;
        document.body.appendChild(container);
      });
  }

  function closeModal() {
    const overlay = document.querySelector('.modal-overlay');
    const card = document.querySelector('.modal-card');
    if (overlay) overlay.remove();
    if (card) card.remove();
  }

  function tambahBarangApi() {
    let nama = prompt("Nama barang?");
    let jenis = prompt("Jenis barang?");
    let harga = prompt("Harga?");
    let stok = prompt("Stok?");
    if (nama && jenis && harga && stok) {
      $.post("../api/barang/tambah.jsp", {
        nama: nama,
        jenis: jenis,
        harga: harga,
        stok: stok
      }, function(res) {
        console.log("Respon tambah:", res);
        if (res.trim() === "ok") {
          alert("Barang berhasil ditambahkan!");
          location.reload();
        } else {
          alert("Gagal menambahkan barang.");
        }
      });
    }
  }

  function hapusBarangApi(id) {
    if (confirm("Hapus barang ini?")) {
      $.post("../api/barang/hapus.jsp", { id: id }, function(res) {
        if (res.trim() === "ok") {
          alert("Barang berhasil dihapus!");
          location.reload();
        } else {
          alert("Gagal menghapus barang.");
        }
      });
    }
  }

  function gantiNamaApi(id) {
    let namabaru = prompt("Ganti nama barang?");
    if (namabaru) {
      $.post("../api/barang/gantinama.jsp", { id: id, namabaru: namabaru }, function(res) {
        console.log("Respon:", res);
        if (res.trim() === "ok") {
          alert("Nama barang diperbarui!");
          $("#nama" + id).html(namabaru);
        } else {
          alert("Gagal memperbarui nama.");
        }
      });
    }
  }

  function tampilkanStatApi() {
    $.post("../api/barang/stat.jsp", function(res) {
      try {
        let obj = JSON.parse(res);
        alert("Jumlah barang: " + obj.banyak + "\nRata-rata harga: Rp " + Math.round(obj.rata2).toLocaleString("id-ID"));
      } catch (e) {
        alert("Gagal membaca statistik.");
        console.error("Respon stat error:", res);
      }
    });
  }
</script>
