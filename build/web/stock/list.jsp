<%
  if (session.getAttribute("user") == null) {
response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Stock, model.StockDetail, tokoatk.StockDAO, tokoatk.StockDetailDAO, tokoatk.UserDAO" %>
<%@ include file="../layout/layout.jsp" %>

<div class="content">
  <div class="container">
    <div class="dashboard-title">
      <h1><i class='bx bx-package'></i> Daftar Stok Masuk</h1>
      <a href="form.jsp?menu=stock" class="btn tambah"><i class='bx bx-plus'></i> Tambah Stok</a>
    </div>

<%
  String status = request.getParameter("status");
  if ("sukses".equals(status)) {
%>
  <div class="notif success"><i class='bx bx-check-circle'></i> Stok berhasil ditambahkan.</div>
<% } else if ("hapus".equals(status)) { %>
  <div class="notif success"><i class='bx bx-check-circle'></i> Stok berhasil dihapus.</div>
<% } else if ("gagal".equals(status)) { %>
  <div class="notif error"><i class='bx bx-error-circle'></i> Gagal memproses data.</div>
<% } %>


    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>ID Stok</th>
            <th>Petugas</th>
            <th>Barang</th>
            <th>Total</th>
            <th>Aksi</th>
          </tr>
        </thead>
        <tbody>
          <% 
            List<Stock> list = StockDAO.getAll(); 
            for (Stock s : list) {
              List<StockDetail> details = StockDetailDAO.getByStockId(s.getId());
              String fullname = UserDAO.getFullnameByUsername(s.getUsername());
              if (details != null && !details.isEmpty()) {
                int total = 0;
          %>
          <tr>
            <td><%= s.getId() %></td>
            <td><%= fullname %></td>
            <td>
              <% 
                for (StockDetail d : details) {
                  String nama = d.getNamaBarang();
                  total += d.getQty() * d.getHarga();
              %>
                <div>
                  <%= (nama != null) ? nama : "<i style='color:#888'>[Barang dihapus]</i>" %> (x<%= d.getQty() %>)
                </div>
              <% } %>
            </td>
            <td>Rp <%= String.format("%,d", total).replace(",", ".") %></td>
            <td>
              <button class="btn icon-only" onclick="loadDetail('<%= s.getId() %>')"><i class='bx bx-info-circle'></i></button>
                <a href="<%= request.getContextPath() %>/stock/hapus?id=<%= s.getId() %>"class="btn icon-only" 
                    accesskey=""onclick="return confirm('Hapus data stok ini?')">
                   <i class='bx bx-trash'></i>
                </a>
            </td>
          </tr>
          <% 
              } // end if details not empty
            } // end for stock list
          %>
        </tbody>
      </table>
    </div>

    <div id="modalContainer"></div>
  </div>
</div>

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
</script>
