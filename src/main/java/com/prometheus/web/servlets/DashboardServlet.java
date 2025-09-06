package com.prometheus.web.servlets;

import com.prometheus.web.model.Alquiler;
import com.prometheus.web.repo.AlquilerRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

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


        // === Filtros ===
        String activoParam = trimOrNull(req.getParameter("activo")); // "", "1", "0"
        String fiParam = trimOrNull(req.getParameter("fi")); // yyyy-MM-dd (input type=date)
        String ffParam = trimOrNull(req.getParameter("ff"));

        java.time.LocalDate fi = parseDateOrNull(fiParam);
        java.time.LocalDate ff = parseDateOrNull(ffParam);

        java.util.List<Alquiler> all = AlquilerRepository.findAll();

        // === Filtrado ===
        java.util.stream.Stream<Alquiler> st = all.stream();

        if ("1".equals(activoParam))
            st = st.filter(Alquiler::isActivo);
        if ("0".equals(activoParam))
            st = st.filter(a -> !a.isActivo());

        // EXACTAMENTE esa fecha (no rango)
        if (fi != null)
            st = st.filter(a -> fi.equals(a.getFechaInicio()));
        if (ff != null)
            st = st.filter(a -> ff.equals(a.getFechaFin()));

        java.util.List<Alquiler> filtered = st.toList();

        // === Métricas con la lista filtrada ===
        java.math.BigDecimal totalMonto = filtered.stream()
                .map(Alquiler::getMontoMensual)
                .filter(java.util.Objects::nonNull)
                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

        int nuevosAlquileres = filtered.size();

        // Cuenta inquilinos distintos dentro de los alquileres filtrados
        long clientesNuevos = filtered.stream()
                .map(a -> a.getInquilinoId()) // o a.getInquilino().getId()
                .filter(java.util.Objects::nonNull)
                .distinct()
                .count();

        // // Carga de datos
        // List<Alquiler> items = AlquilerRepository.findAll(); // o lo que necesites
        // List<Inquilino> inquilinoItems = InquilinoRepository.findAll();

        // req.setAttribute("items", items);
        // req.setAttribute("inquilinoItems", inquilinoItems);

        // // Total (BigDecimal)
        // java.math.BigDecimal total = java.math.BigDecimal.ZERO;
        // for (Alquiler a : items) {
        //     java.math.BigDecimal m = a.getMontoMensual();
        //     if (m != null)
        //         total = total.add(m);
        // }

        req.setAttribute("items", filtered);

        // Para las cards
        req.setAttribute("totalMonto", totalMonto);
        req.setAttribute("alquileresNuevos", nuevosAlquileres);
        req.setAttribute("clientesNuevos", (int) clientesNuevos);

        // Para “sticky filters”
        req.setAttribute("f_activo", activoParam == null ? "" : activoParam);
        req.setAttribute("f_fi", fiParam == null ? "" : fiParam);
        req.setAttribute("f_ff", ffParam == null ? "" : ffParam);

        // req.setAttribute("totalMonto", total);
        // req.setAttribute("inqCount", inquilinoItems.size());
        // req.setAttribute("alqCount", items.size());

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
    }

    private static String trimOrNull(String s) {
        return (s == null || s.isBlank()) ? null : s.trim();
    }

    private static java.time.LocalDate parseDateOrNull(String s) {
        if (s == null || s.isBlank())
            return null;
        try {
            // input type="date" => ISO yyyy-MM-dd
            return java.time.LocalDate.parse(s);
        } catch (Exception e) {
            try {
                // por si algún día enviamos dd/MM/yyyy
                return java.time.LocalDate.parse(s, java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            } catch (Exception ignore) {
                return null;
            }
        }
    }
}
