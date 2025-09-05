package com.prometheus.web.servlets;

import com.prometheus.web.model.Alquiler;
import com.prometheus.web.model.Inquilino;
import com.prometheus.web.repo.AlquilerRepository;
import com.prometheus.web.repo.InquilinoRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
        "/dashboard", // GET listar
        "/dashboard/", // GET listar
})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Carga de datos
        List<Alquiler> items = AlquilerRepository.findAll(); // o lo que necesites
        List<Inquilino> inquilinoItems = InquilinoRepository.findAll();

        req.setAttribute("items", items);
        req.setAttribute("inquilinoItems", inquilinoItems);

        // Total (BigDecimal)
        java.math.BigDecimal total = java.math.BigDecimal.ZERO;
        for (Alquiler a : items) {
            java.math.BigDecimal m = a.getMontoMensual();
            if (m != null)
                total = total.add(m);
        }
        req.setAttribute("totalMonto", total);
        req.setAttribute("inqCount", inquilinoItems.size());
        req.setAttribute("alqCount", items.size());


        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
    }

}
