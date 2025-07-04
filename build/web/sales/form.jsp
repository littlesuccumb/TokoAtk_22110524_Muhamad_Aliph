<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Barang, tokoatk.BarangDAO" %>
<%
  if (session.getAttribute("user") == null) {
response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }

  String fullname = (String) session.getAttribute("fullname");
  List<Barang> barangList = BarangDAO.getAll();
%>

<%@ include file="../layout/layout.jsp" %>

<div class="content">
  <div class="container">
    <div class="form-wrapper">
      <h2><i class='bx bx-cart'></i> Transaksi Penjualan</h2>
      <form action="tambah" method="post" onsubmit="return validateForm()">
        <!-- Tidak perlu input tanggal -->
        <input type="hidden" name="nama" value="<%= fullname %>">

        <div class="form-group">
          <label class="form-label">Barang</label>
          <select name="barangId" id="barangId" onchange="updateHarga()">
            <option value="" disabled selected>--- Pilih Barang ---</option>
            <% for (Barang b : barangList) { %>
              <option value="<%= b.getId() %>" data-harga="<%= b.getHarga() %>"><%= b.getNama() %></option>
            <% } %>
          </select>
        </div>

        <div class="form-group">
          <label class="form-label">Jumlah</label>
          <input type="number" name="jumlah" id="jumlah" placeholder="Masukkan jumlah" min="1" onchange="updateTotal()" required />
        </div>

        <div class="form-group">
          <label class="form-label">Harga</label>
          <input type="hidden" name="harga" id="harga" required />
          <input type="text" id="hargaDisplay" readonly />
        </div>

        <div class="form-group">
          <label class="form-label">Total Harga</label>
          <input type="text" id="totalDisplay" readonly />
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
  const harga = parseInt(selected.getAttribute("data-harga") || 0);
  document.getElementById("harga").value = harga;
  document.getElementById("hargaDisplay").value = formatRupiah(harga);
  updateTotal();
}

function updateTotal() {
  const harga = parseInt(document.getElementById("harga").value || 0);
  const jumlah = parseInt(document.getElementById("jumlah").value || 0);
  const total = harga * jumlah;
  document.getElementById("totalDisplay").value = formatRupiah(total);
}

function validateForm() {
  const barang = document.getElementById("barangId").value;
  const jumlah = document.getElementById("jumlah").value;
  if (!barang || !jumlah) {
    alert("Barang dan jumlah harus diisi.");
    return false;
  }
  return true;
}
</script>
