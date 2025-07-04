package controller.barang;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import tokoatk.BarangDAO;

@WebServlet("/barang/hapus")
public class HapusBarangServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            BarangDAO.delete(id);
            res.sendRedirect("list.jsp?status=hapus");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }
}
