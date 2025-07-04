package controller.sales;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.*;
import model.Sales;
import model.SalesDetail;
import tokoatk.SalesDAO;

@WebServlet("/sales/tambah")
public class TambahSalesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String username = (String) req.getSession().getAttribute("user");
            String barangId = req.getParameter("barangId");
            String jumlahStr = req.getParameter("jumlah");
            String hargaStr = req.getParameter("harga");

            System.out.println("DEBUG: username = " + username);
            System.out.println("DEBUG: barangId = " + barangId);
            System.out.println("DEBUG: jumlah   = " + jumlahStr);
            System.out.println("DEBUG: harga    = " + hargaStr);

            if (username == null || barangId == null || jumlahStr == null || hargaStr == null) {
                throw new Exception("Data tidak lengkap, parameter null.");
            }

            int qty = Integer.parseInt(jumlahStr);
            int harga = Integer.parseInt(hargaStr);

            Sales sales = new Sales();
            sales.setId(generateId("TRX"));
            sales.setUsername(username);
            sales.setWaktu(new Date()); // ⬅️ SIMPAN WAKTU SEKARANG LENGKAP (tanggal + jam)

            SalesDetail detail = new SalesDetail(sales.getId(), barangId, qty, harga);
            sales.setDetails(Collections.singletonList(detail));

            SalesDAO.insert(sales);
            res.sendRedirect("list.jsp?status=tambah");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }

    private String generateId(String prefix) {
        return prefix + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    }
}
