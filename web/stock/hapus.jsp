<%@ page import="tokoatk.StockDAO" %>
<%
    String id = request.getParameter("id");

    try {
        StockDAO.delete(id);
        response.sendRedirect("list.jsp?status=sukses");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("list.jsp?status=gagal");
    }
%>
