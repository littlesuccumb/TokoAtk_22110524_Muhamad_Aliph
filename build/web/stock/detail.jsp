<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Stock, model.StockDetail, tokoatk.StockDAO, tokoatk.StockDetailDAO, tokoatk.UserDAO" %>

<%
    String id = request.getParameter("id");
    Stock stock = StockDAO.getById(id);

    if (stock == null) {
%>
    <div class="modal-overlay" onclick="closeModal()"></div>
    <div class="modal-card">
      <div class="modal-header">
        <h2>Detail Stok</h2>
        <button onclick="closeModal()" class="close-btn"><i class='bx bx-x'></i></button>
      </div>
      <div class="modal-body">
        <p style="color:red;">Data stok tidak ditemukan.</p>
      </div>
    </div>
<%
    return;
    }

    List<StockDetail> details = StockDetailDAO.getByStockId(id);
    String fullname = UserDAO.getFullnameByUsername(stock.getUsername());
    String formattedDate = new java.text.SimpleDateFormat("dd MMMM yyyy, HH:mm", new java.util.Locale("id")).format(stock.getWaktu());
%>

<div class="modal-overlay" onclick="closeModal()"></div>
<div class="modal-card">
  <div class="modal-header">
    <h2>Detail Stok Masuk</h2>
    <button onclick="closeModal()" class="close-btn"><i class='bx bx-x'></i></button>
  </div>
    <hr>
  <div class="modal-body">
    <p><strong>ID Stok:</strong> <%= stock.getId() %></p>
    <p><strong>Waktu:</strong> <%= formattedDate %></p>
    <p><strong>Petugas:</strong> <%= fullname %></p>
    <hr>
    <% if (details != null && !details.isEmpty()) { %>
      <% for (StockDetail d : details) { %>
        <p><strong>ID Barang:</strong> <%= d.getBarangId() %></p>
        <p><strong>Nama Barang:</strong> <%= d.getNamaBarang() %></p>
        <p><strong>Jumlah:</strong> <%= d.getQty() %></p>
        <p><strong>Harga:</strong> Rp <%= String.format("%,d", d.getHarga()).replace(",", ".") %></p>
        <p><strong>Total:</strong> Rp <%= String.format("%,d", d.getHarga() * d.getQty()).replace(",", ".") %></p>
        <hr>
      <% } %>
    <% } else { %>
      <p>Data detail stok tidak tersedia.</p>
    <% } %>
  </div>
</div>
