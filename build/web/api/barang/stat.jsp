<%@page import="java.util.List"%>
<%@page import="model.Barang"%>
<%@page import="tokoatk.BarangDAO"%>
<%
    List<Barang> list = BarangDAO.getAll();

    int banyak = list.size();
    int total = 0;
    double rata2 = 0.0;

    for (Barang b : list) {
        total += b.getHarga();
    }

    if (banyak > 0) {
        rata2 = (double) total / banyak;
    }

    // Output dalam format JSON
    out.print("{\"banyak\":" + banyak + ",\"rata2\":" + rata2 + "}");
%>
