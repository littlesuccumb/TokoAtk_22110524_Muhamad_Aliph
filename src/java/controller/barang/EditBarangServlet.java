// ================================
// File: controller.barang.EditBarangServlet.java
// ================================
package controller.barang;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import model.Barang;
import tokoatk.BarangDAO;

@WebServlet("/barang/edit")
public class EditBarangServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            String nama = req.getParameter("nama");
            String jenis = req.getParameter("jenis");
            int harga = Integer.parseInt(req.getParameter("harga"));
            int stok = Integer.parseInt(req.getParameter("stok"));

            Barang barang = new Barang(id, nama, jenis, harga, stok);
            BarangDAO.update(barang);
            res.sendRedirect("list.jsp?status=ubah");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }
}
