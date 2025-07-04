<%
  if (session.getAttribute("user") == null) {
response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Sales, model.SalesDetail, tokoatk.SalesDAO, tokoatk.SalesDetailDAO, tokoatk.UserDAO" %>
<%@ include file="../layout/layout.jsp" %>

<div class="content">
  <div class="container">
    <div class="dashboard-title">
      <h1><i class='bx bx-cart'></i> Daftar Transaksi Penjualan</h1>
      <div style="display:flex; gap:10px;">
        <a href="form.jsp?menu=sales" class="btn tambah"><i class='bx bx-plus'></i> Tambah Transaksi</a>
        <button class="btn tambah" onclick="cekTotal()"><i class='bx bx-calculator'></i> Cek Total via API</button>
      </div>
    </div>

    <% 
      String status = request.getParameter("status");
      if ("tambah".equals(status)) {
    %>
      <div class="notif success"><i class='bx bx-check-circle'></i> Transaksi berhasil disimpan.</div>
    <% } else if ("hapus".equals(status)) { %>
      <div class="notif success"><i class='bx bx-check-circle'></i> Transaksi berhasil dihapus.</div>
    <% } else if ("gagal".equals(status)) { %>
      <div class="notif error"><i class='bx bx-error-circle'></i> Gagal memproses transaksi.</div>
    <% } %>

    <div class="search-wrapper">
      <div class="search-box">
        <i class='bx bx-search'></i>
        <input type="text" id="searchInput" placeholder="Cari transaksi, nama pembeli, atau barang..." />
      </div>
    </div>

    <div class="table-wrapper">
      <table id="salesTable">
        <thead>
          <tr>
            <th onclick="sortTable(0, 'salesTable')">ID Transaksi</th>
            <th onclick="sortTable(1, 'salesTable')">Nama Pembeli</th>
            <th onclick="sortTable(2, 'salesTable')">ID Barang</th>
            <th onclick="sortTable(3, 'salesTable')">Nama Barang</th>
            <th onclick="sortTable(4, 'salesTable')">Jumlah</th>
            <th onclick="sortTable(5, 'salesTable')">Subtotal</th>
            <th>Aksi</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Sales> list = SalesDAO.getAll();
            for (Sales s : list) {
              List<SalesDetail> details = SalesDetailDAO.getBySalesId(s.getId());
              String pembeli = UserDAO.getFullnameByUsername(s.getUsername());

              if (details != null && !details.isEmpty()) {
                for (SalesDetail d : details) {
                  int subtotal = d.getQty() * d.getHarga();
                  String namaBarang = (d.getNamaBarang() != null) ? d.getNamaBarang() : "<i style='color:#888'>[Barang dihapus]</i>";
          %>
            <tr>
              <td><%= s.getId() %></td>
              <td><%= pembeli %></td>
              <td><%= d.getBarangId() %></td>
              <td><%= namaBarang %></td>
              <td><%= d.getQty() %></td>
              <td>Rp <%= String.format("%,d", subtotal).replace(",", ".") %></td>
              <td>
                <button class="btn icon-only" onclick="loadDetail('<%= s.getId() %>')"><i class='bx bx-show'></i></button>
                <a href="<%= request.getContextPath() %>/sales/hapus?id=<%= s.getId() %>" 
                   class="btn icon-only" 
                   onclick="return confirm('Hapus transaksi ini?')">
                  <i class='bx bx-trash'></i>
                </a>
              </td>
            </tr>
          <%
                }
              } else {
          %>
            <tr>
              <td colspan="7" style="text-align:center; color:#999;">
                Transaksi <strong><%= s.getId() %></strong> tidak memiliki data barang.
              </td>
            </tr>
          <%
              }
            }
          %>
        </tbody>
      </table>
    </div>

    <div id="modalContainer"></div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
  function loadDetail(id) {
    fetch("detail.jsp?id=" + id)
      .then(res => res.text())
      .then(html => {
        document.getElementById("modalContainer").innerHTML = html;
      });
  }

  function closeModal() {
    document.getElementById("modalContainer").innerHTML = "";
  }

function cekTotal() {
  const id = prompt("Masukkan ID Transaksi yang ingin dihitung totalnya:");
  if (!id) return;

  $.post("../api/sales/total.jsp", { id: id }, function(res) {
    console.log("Respon dari API:", res); // res sekarang adalah objek, bukan string
    alert("Total transaksi " + id + ": Rp " + res.total.toLocaleString("id-ID"));
  });
}

</script>
