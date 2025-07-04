package controller.stock;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import tokoatk.StockDAO;

@WebServlet("/stock/hapus")
public class HapusStockServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            StockDAO.delete(id);
            res.sendRedirect("list.jsp?status=hapus");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }
}
