<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, java.util.List" %>
<%@ page import="tokoatk.UserDAO" %>
<%@ include file="../layout/layout.jsp" %>

<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect("../index.jsp?pesan=belumlogin");
    return;
  }
  List<User> daftarUser = UserDAO.getAll();
  String status = request.getParameter("status");
%>

<div class="content">
  <div class="container">
    <div class="dashboard-title">
      <h1><i class='bx bx-user'></i> Data Pengguna</h1>
    </div>

    <% if ("ubah".equals(status)) { %>
      <div class="notif success"><i class='bx bx-check-circle'></i> Data pengguna berhasil diupdate.</div>
    <% } %>

    <div class="search-wrapper">
      <div class="search-box">
        <i class='bx bx-search'></i>
        <input type="text" id="searchInput" placeholder="Cari pengguna...">
      </div>
    </div>

    <div class="table-wrapper">
      <table id="userTable">
        <thead>
          <tr>
            <th>No</th>
            <th>Username</th>
            <th>Nama Lengkap</th>
            <th>Aksi</th>
          </tr>
        </thead>
        <tbody>
        <%
          int no = 1;
          for (User u : daftarUser) {
        %>
          <tr>
            <td><%= no++ %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getFullname() %></td>
            <td>
              <button class="btn icon-only detail-btn"
                      data-username="<%= u.getUsername() %>"
                      data-fullname="<%= u.getFullname() %>">
                <i class='bx bx-info-circle'></i>
              </button>
              <a href="form.jsp?username=<%= u.getUsername() %>" class="btn icon-only" title="Edit">
                <i class='bx bx-edit'></i>
              </a>
              <a href="hapus?username=<%= u.getUsername() %>" class="btn icon-only" title="Hapus"
                 onclick="return confirm('Hapus user ini?')">
                <i class='bx bx-trash'></i>
              </a>
            </td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- MODAL DETAIL -->
<div id="userModal" class="modal-overlay" style="display:none;">
  <div class="modal-card">
    <div class="modal-header">
      <h2>Detail Pengguna</h2>
      <button class="close-btn" onclick="closeModal()">×</button>
    </div>
      <hr>
    <div class="modal-body">
      <p><strong>Username:</strong> <span id="modalUsername"></span></p>
      <p><strong>Nama Lengkap:</strong> <span id="modalFullname"></span></p>
    </div>
  </div>
</div>

<!-- SCRIPT SEARCH + MODAL -->
<script>
function closeModal() {
  document.getElementById('userModal').style.display = 'none';
}

document.querySelectorAll('.detail-btn').forEach(btn => {
  btn.addEventListener('click', function () {
    const username = this.dataset.username;
    const fullname = this.dataset.fullname;
    document.getElementById('modalUsername').textContent = username;
    document.getElementById('modalFullname').textContent = fullname;
    document.getElementById('userModal').style.display = 'block';
  });
});

// Search Filter
document.getElementById("searchInput").addEventListener("keyup", function () {
  const value = this.value.toLowerCase();
  document.querySelectorAll("#userTable tbody tr").forEach(row => {
    const text = row.innerText.toLowerCase();
    row.style.display = text.includes(value) ? "" : "none";
  });
});
</script>
