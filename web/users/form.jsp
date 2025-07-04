<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="tokoatk.UserDAO" %>
<%@ include file="../layout/layout.jsp" %>

<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect("../index.jsp?pesan=belumlogin");
    return;
  }

  String userParam = request.getParameter("username");
  User user = UserDAO.getByUsername(userParam);
%>

<div class="content">
  <div class="container">
    <div class="form-wrapper">
      <h2><i class='bx bx-key'></i> Ganti Password</h2>
      <form action="../users/update" method="post">
        <input type="hidden" name="username" value="<%= user.getUsername() %>" />

        <div class="form-group">
          <label>Nama Lengkap</label>
          <input type="text" name="fullname" value="<%= user.getFullname() %>" required />
        </div>

        <div class="form-group">
          <label>Password Baru</label>
          <input type="password" name="password" placeholder="Kosongkan jika tidak ingin mengubah" />
        </div>

        <div class="form-button-group">
          <button type="submit" class="btn simpan"><i class='bx bx-save'></i> Simpan</button>
          <a href="../home.jsp?menu=dashboard" class="btn batal"><i class='bx bx-arrow-back'></i> Kembali</a>
        </div>
      </form>
    </div>
  </div>
</div>
