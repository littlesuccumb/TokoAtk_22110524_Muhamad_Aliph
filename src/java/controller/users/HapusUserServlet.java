package controller.users;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import tokoatk.UserDAO;

import java.io.IOException;

@WebServlet("/users/hapus")
public class HapusUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        UserDAO.delete(username);
        res.sendRedirect("list.jsp?status=hapus");
    }
}
