<%@ page import="model.Barang" %>
<%
    try {
        String nama = request.getParameter("nama");
        String jenis = request.getParameter("jenis");
        int harga = Integer.parseInt(request.getParameter("harga"));
        int stok = Integer.parseInt(request.getParameter("stok"));

        System.out.println("Tambah BARANG API - Masuk:");
        System.out.println("nama = " + nama);
        System.out.println("jenis = " + jenis);
        System.out.println("harga = " + harga);
        System.out.println("stok = " + stok);

        Barang barang = new Barang();
        barang.generateId();
        barang.setNama(nama);
        barang.setJenis(jenis);
        barang.setHarga(harga);
        barang.setStok(stok);

        if (barang.insert()) {
            out.print("ok");
        } else {
            System.out.println("Insert gagal.");
            out.print("fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("fail");
    }
%>
