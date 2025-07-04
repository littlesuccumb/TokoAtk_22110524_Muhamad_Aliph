<%@ page import="model.Barang" %>
<%
    String id = request.getParameter("id");

    Barang barang = new Barang();
    barang.setId(id);

    if (barang.delete()) {
        out.print("ok");
    } else {
        out.print("fail");
    }
%>
