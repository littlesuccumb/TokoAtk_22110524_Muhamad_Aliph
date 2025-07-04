<%@ page import="tokoatk.UserDAO" %>
<%@ page session="true" %>
<%@ page import="tokoatk.LogDAO" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    boolean isValid = UserDAO.login(username, password);

    if (isValid) {
        String fullname = UserDAO.getFullnameByUsername(username);
        session.setAttribute("user", username);
        session.setAttribute("username", username);
        session.setAttribute("fullname", fullname);
        
                // ? Tambahkan log login di sini
        LogDAO.tambahLog(username, "Login ke sistem");        
        // redirect ke home.jsp dengan parameter pesan=login
        response.sendRedirect("../home.jsp?pesan=login");
    } else {
        response.sendRedirect("../index.jsp?pesan=gagal");
    }
%>
