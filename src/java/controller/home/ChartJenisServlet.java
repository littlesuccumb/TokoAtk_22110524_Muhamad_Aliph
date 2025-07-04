package controller.home;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import tokoatk.SalesDAO;

import java.io.IOException;
import java.util.Map;

@WebServlet("/chart-jenis")
public class ChartJenisServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> chartJenis = SalesDAO.getChartDataByJenis();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(chartJenis));
    }
}
