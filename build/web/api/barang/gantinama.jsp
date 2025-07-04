<%@ page import="model.Barang" %>
<%
    String id = request.getParameter("id");
    String namabaru = request.getParameter("namabaru");

    Barang barang = new Barang();
    barang.baca(id);
    barang.setNama(namabaru);

    if (barang.update()) {
        out.print("ok");
    } else {
        out.print("fail");
    }
%>
