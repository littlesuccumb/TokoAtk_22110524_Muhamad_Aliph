package controller.stock;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import model.Stock;
import model.StockDetail;
import tokoatk.StockDAO;

@WebServlet("/stock/tambah")
public class TambahStockServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String username = (String) req.getSession().getAttribute("user");
            String tanggal = req.getParameter("tanggal");
            String[] barangId = req.getParameterValues("barangId");
            String[] jumlah = req.getParameterValues("jumlah");
            String[] harga = req.getParameterValues("harga");

            Stock stock = new Stock();
            stock.setId(generateId("IN"));
            stock.setUsername(username);
            stock.setWaktu(new Date());

            List<StockDetail> details = new ArrayList<>();
            for (int i = 0; i < barangId.length; i++) {
                StockDetail detail = new StockDetail(stock.getId(), barangId[i], Integer.parseInt(jumlah[i]), Integer.parseInt(harga[i]));
                details.add(detail);
            }
            stock.setDetails(details);

            StockDAO.insert(stock);
            res.sendRedirect("list.jsp?status=sukses");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("list.jsp?status=gagal");
        }
    }

    private String generateId(String prefix) {
        return prefix + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    }
}
