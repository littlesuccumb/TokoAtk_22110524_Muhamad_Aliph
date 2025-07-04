// ================================
// File: controller.barang.TambahBarangServlet.java
// ================================
package controller.barang;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.Random;

import model.Barang;
import tokoatk.BarangDAO;
import tokoatk.LogDAO; // tambahkan import log

@WebServlet("/barang/tambah")
public class TambahBarangServlet extends HttpServlet {

    private String generateId() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder id = new StringBuilder("BRG");
        Random rand = new Random();
        for (int i = 0; i < 5; i++) {
            id.append(chars.charAt(rand.nextInt(chars.length())));
        }
        return id.toString();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String nama = req.getParameter("nama");
            String jenis = req.getParameter("jenis");
            int harga = Integer.parseInt(req.getParameter("harga"));
            int stok = Integer.parseInt(req.getParameter("stok"));

            String id = generateId();
            Barang barang = new Barang(id, nama, jenis, harga, stok);
            BarangDAO.insert(barang);

            // Logging aktivitas
            HttpSession session = req.getSession();
            String username = (String) session.getAttribute("user");
            LogDAO.tambahLog(username, "Menambahkan barang baru: " + nama + " (" + id + ")");

            res.sendRedirect("list.jsp?status=tambah");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }
}
