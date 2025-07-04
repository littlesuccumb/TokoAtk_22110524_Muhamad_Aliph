<%
  if (session.getAttribute("user") == null) {
response.sendRedirect(request.getContextPath() + "/index.jsp?pesan=belumlogin");
    return;
  }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Barang" %>
<%@ page import="tokoatk.BarangDAO" %>
<%@ include file="../layout/layout.jsp" %>

<%
    String idParam = request.getParameter("id");
    boolean isEdit = false;
    Barang barang = new Barang();

    if (idParam != null && !idParam.isEmpty()) {
        isEdit = true;
        barang = BarangDAO.getById(idParam);
    }

    String formAction = isEdit ? "edit" : "tambah";
%>

<div class="content">
  <div class="container">
    <div class="form-wrapper">
      <h2><i class='bx <%= isEdit ? "bx-edit" : "bx-plus" %>'></i> 
        <%= isEdit ? "Edit" : "Tambah" %> Barang
      </h2>

      <form action="<%= formAction %>" method="post">
        <% if (isEdit) { %>
          <input type="hidden" name="id" value="<%= barang.getId() %>" />
        <% } %>

        <div class="form-group">
          <label>Nama</label>
          <input type="text" name="nama" value='<%= isEdit ? barang.getNama() : "" %>' required />
        </div>

        <div class="form-group">
          <label>Jenis</label>
          <input type="text" name="jenis" value='<%= isEdit ? barang.getJenis() : "" %>' required />
        </div>

        <div class="form-group">
          <label>Harga</label>
          <input type="number" name="harga" value='<%= isEdit ? barang.getHarga() : "" %>' required />
        </div>

        <div class="form-group">
          <label>Stok</label>
          <input type="number" name="stok" id="stok" value='<%= isEdit ? barang.getStok() : "" %>' required />
        </div>

        <div class="form-button-group">
          <button type="submit" class="btn simpan"><i class='bx bx-save'></i> Simpan</button>
          <a href="list.jsp" class="btn batal"><i class='bx bx-x'></i> Batal</a>
        </div>
      </form>
    </div>
  </div>
</div>
