<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tokoatk.BarangDAO, model.Barang" %>

<%
  String id = request.getParameter("id");
  Barang b = BarangDAO.getById(id);
%>

<div class="modal-overlay" onclick="closeModal()"></div>
<div class="modal-card">
  <div class="modal-header">
    <h2>Detail Barang</h2>
    <button onclick="closeModal()" class="close-btn"><i class='bx bx-x'></i></button>
  </div>
    <hr>
  <div class="modal-body">
    <% if (b != null) { %>
      <p><strong>ID:</strong> <%= b.getId() %></p>
      <p><strong>Nama:</strong> <%= b.getNama() %></p>
      <p><strong>Jenis:</strong> <%= b.getJenis() %></p>
      <p><strong>Harga:</strong> Rp <%= String.format("%,d", b.getHarga()).replace(",", ".") %></p>
      <p><strong>Stok:</strong> <%= b.getStok() %> pcs</p>
    <% } else { %>
      <p style="color:red;">Data barang tidak ditemukan.</p>
    <% } %>
  </div>
</div>
