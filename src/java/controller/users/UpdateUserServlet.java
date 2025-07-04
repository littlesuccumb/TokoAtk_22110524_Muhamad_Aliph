package controller.users;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import tokoatk.UserDAO;

import java.io.IOException;

@WebServlet("/users/update")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");

        User u = new User(username, fullname, null);
        if (password != null && !password.trim().isEmpty()) {
            u.setPassword(password);
            UserDAO.update(u);
        } else {
            u.setPassword(UserDAO.getByUsername(username).getPassword());
            UserDAO.update(u); // tetap pakai update, password diset ulang
        }

        res.sendRedirect("list.jsp?status=ubah");
    }
}
