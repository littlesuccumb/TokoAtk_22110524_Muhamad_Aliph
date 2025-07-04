<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Barang, tokoatk.BarangDAO, tokoatk.UserDAO" %>
<%@ include file="../layout/layout.jsp" %>

<%
  // Ambil username dan fullname dari session, tanpa deklarasi ulang 'username'
  String currentUsername = (String) session.getAttribute("username");

  if (currentUsername == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }

  String fullname = (String) session.getAttribute("fullname");
  if (fullname == null || fullname.isEmpty()) {
    fullname = UserDAO.getFullnameByUsername(currentUsername);
  }

  List<Barang> barangList = BarangDAO.getAll();
  String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>

<div class="content">
  <div class="container">
    <div class="form-wrapper">
      <h2><i class='bx bx-package'></i> Tambah Stok Masuk</h2>
      <form action="tambah" method="post" onsubmit="return validateStockForm()">
        <!-- Petugas otomatis -->
        <input type="hidden" name="petugas" value="<%= fullname %>" />

        <div class="barang-item">
          <div class="form-group">
            <label class="form-label">Barang</label>
            <select name="barangId" id="barangId" onchange="updateHarga()" required>
              <option value="" disabled selected>--- Pilih Barang ---</option>
              <% for (Barang b : barangList) { %>
              <option value="<%= b.getId() %>" data-harga="<%= b.getHarga() %>"><%= b.getNama() %></option>
              <% } %>
            </select>
          </div>

          <div class="form-group">
            <label class="form-label">Jumlah</label>
            <input type="number" name="jumlah" placeholder="Masukkan jumlah" min="1" required />
          </div>

          <div class="form-group">
            <label class="form-label">Harga</label>
            <input type="hidden" name="harga" id="harga" required />
            <input type="text" id="hargaDisplay" readonly />
          </div>
        </div>

        <div class="form-button-group">
          <button type="submit" class="btn simpan"><i class='bx bx-save'></i> Simpan</button>
          <a href="list.jsp" class="btn batal"><i class='bx bx-x'></i> Batal</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function formatRupiah(angka) {
  return new Intl.NumberFormat("id-ID", { style: "currency", currency: "IDR" }).format(angka);
}

function updateHarga() {
  const select = document.getElementById("barangId");
  const selected = select.options[select.selectedIndex];
  const harga = parseInt(selected.getAttribute("data-harga")) || 0;

  document.getElementById("harga").value = harga;
  document.getElementById("hargaDisplay").value = formatRupiah(harga);
}

function validateStockForm() {
  const select = document.getElementById("barangId");
  if (!select.value) {
    alert("Silakan pilih barang terlebih dahulu.");
    return false;
  }
  return true;
}

window.addEventListener("DOMContentLoaded", () => {
  updateHarga();
});
</script>
