<%@page contentType="application/json"%>
<%@page import="tokoatk.SalesDAO, model.SalesDetail, java.util.List" %>
<%
    String id = request.getParameter("id");
    List<SalesDetail> list = SalesDAO.getDetail(id);

    int total = 0;
    for (SalesDetail d : list) {
        total += d.getQty() * d.getHarga();
    }

    out.print("{\"total\": " + total + "}");
%>
