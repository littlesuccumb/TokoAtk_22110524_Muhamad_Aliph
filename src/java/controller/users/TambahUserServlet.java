package controller.users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;
import tokoatk.UserDAO;

@WebServlet("/users/tambah")
public class TambahUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            // Ambil data dari form
            String username = req.getParameter("username");
            String fullname = req.getParameter("fullname");
            String password = req.getParameter("password");

            // Validasi input sederhana
            if (username == null || fullname == null || password == null ||
                username.isEmpty() || fullname.isEmpty() || password.isEmpty()) {
                res.sendRedirect("../index.jsp?register=kosong");
                return;
            }

            // Cek apakah username sudah ada
            if (UserDAO.getByUsername(username) != null) {
                res.sendRedirect("../index.jsp?register=duplikat");
                return;
            }

            // Simpan user baru
            User u = new User();
            u.setUsername(username);
            u.setFullname(fullname);
            u.setPassword(password); // DAO sudah handle MD5

            boolean sukses = UserDAO.insert(u);

            if (sukses) {
                res.sendRedirect("../index.jsp?register=success");
            } else {
                res.sendRedirect("../index.jsp?register=gagal");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("../index.jsp?register=gagal");
        }
    }
}
