package controller.sales;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import tokoatk.SalesDAO;

@WebServlet("/sales/hapus")
public class HapusSalesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            SalesDAO.delete(id);
            res.sendRedirect("list.jsp?status=hapus");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }
}
