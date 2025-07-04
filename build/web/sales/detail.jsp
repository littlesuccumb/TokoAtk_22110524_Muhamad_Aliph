<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Sales, model.SalesDetail, tokoatk.SalesDAO, tokoatk.SalesDetailDAO, tokoatk.UserDAO" %>

<%
    String id = request.getParameter("id");
    Sales sales = SalesDAO.getById(id);
    List<SalesDetail> details = SalesDetailDAO.getBySalesId(id);
    SalesDetail detail = details.size() > 0 ? details.get(0) : null;

    String fullname = UserDAO.getFullnameByUsername(sales.getUsername());
    String formattedDate = new java.text.SimpleDateFormat("dd MMMM yyyy, HH:mm", new java.util.Locale("id")).format(sales.getWaktu());
%>

<div class="modal-overlay" onclick="closeModal()"></div>
<div class="modal-card">
  <div class="modal-header">
    <h2>Detail Transaksi</h2>
    <button onclick="closeModal()" class="close-btn"><i class='bx bx-x'></i></button>
  </div>
    <hr>
  <div class="modal-body">
    <p><strong>ID Transaksi:</strong> <%= sales.getId() %></p>
    <p><strong>Waktu:</strong> <%= formattedDate %></p>
    <p><strong>Nama Pembeli:</strong> <%= fullname %></p>
    <hr>
    <% if (detail != null) { %>
      <p><strong>ID Barang:</strong> <%= detail.getBarangId() %></p>
      <p><strong>Nama Barang:</strong> <%= detail.getNamaBarang() %></p>
      <p><strong>Jumlah:</strong> <%= detail.getQty() %></p>
      <p><strong>Harga:</strong> Rp <%= String.format("%,d", detail.getHarga()).replace(",", ".") %></p>
      <p><strong>Sub Total:</strong> Rp <%= String.format("%,d", detail.getHarga() * detail.getQty()).replace(",", ".") %></p>
    <% } else { %>
      <p>Data detail tidak ditemukan.</p>
    <% } %>
  </div>
</div>
