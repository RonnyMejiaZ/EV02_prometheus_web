package com.prometheus.web.servlets;

import com.prometheus.web.model.Pago;
import com.prometheus.web.repo.PagoRepository;
import com.prometheus.web.repo.AlquilerRepository;
import com.prometheus.web.util.Pagination;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.math.BigDecimal;

@WebServlet(urlPatterns = {
        "/pagos", // GET listar
        "/pagos/", // GET listar
        "/pagos/listar", // GET listar
        "/pagos/crear", // GET (form crear/editar)
        "/pagos/guardar", // POST (crear o editar)
        "/pagos/eliminar" // POST (eliminar)
})
public class PagosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String uri = req.getRequestURI();

        if (uri.endsWith("/pagos") ||
                uri.endsWith("/pagos/") ||
                uri.endsWith("/pagos/listar")) {

            var p = Pagination.readParams(req);
            var pr = PagoRepository.searchPage(p.q, p.page, p.size);
            Pagination.fill(req, p, pr);

            req.setAttribute("active", "pagos");

            req.getRequestDispatcher("/pagos/listar.jsp").forward(req, resp);
            return;
        }

        // FORM CREAR / EDITAR
        if (uri.endsWith("/pagos/crear")) {
            long id = parseLong(req.getParameter("id"), 0);
            if (id > 0) {
                Pago p = PagoRepository.findById(id);
                if (p == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                req.setAttribute("item", p); // ← si existe, modo edición
                req.setAttribute("alquileres", AlquilerRepository.findAll());
            }
            req.setAttribute("alquileres", AlquilerRepository.findAll());
            req.getRequestDispatcher("/pagos/crear.jsp").forward(req, resp);
            return;
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();

        // CREAR o EDITAR (un solo endpoint)
        if (uri.endsWith("/pagos/guardar")) {
            long id = parseLong(req.getParameter("id"), 0);

            Pago p = (id > 0) ? PagoRepository.findById(id) : new Pago();
            if (id > 0 && p == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            p.setAlquilerId(parseLong(req.getParameter("alquilerId"), 0));
            p.setFechaPago(LocalDate.parse(req.getParameter("fechaPago")));
            p.setMontoMensual(new BigDecimal(req.getParameter("montoMensual")));
            p.setAlquilerPago("1".equals(req.getParameter("alquilerPago")));
            p.setCompAlquiler(req.getParameter("compAlquiler"));
            p.setReciboAgua(req.getParameter("reciboAgua"));
            p.setCompAgua(req.getParameter("compAgua"));
            p.setReciboEnergia(req.getParameter("reciboEnergia"));
            p.setCompEnergia(req.getParameter("compEnergia"));
            p.setReciboGas(req.getParameter("reciboGas"));
            p.setCompGas(req.getParameter("compGas"));

            PagoRepository.save(p);

            if (id > 0) {
                PagoRepository.update(p);
                req.getSession().setAttribute("msg", "Pago actualizado");
            } else {
                PagoRepository.save(p);
                req.getSession().setAttribute("msg", "Pago creado");
            }

            // Si es creación y presionó "Crear y crear otro"
            String again = req.getParameter("again");
            if (id == 0 && "1".equals(again)) {
                resp.sendRedirect(req.getContextPath() + "/pagos/crear");
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/pagos");
            return;
        }

        // ELIMINAR
        if (uri.endsWith("/pagos/eliminar")) {
            long id = parseLong(req.getParameter("id"), -1);
            boolean ok = PagoRepository.deleteById(id);
            req.getSession().setAttribute("msg", ok ? "Pago eliminado" : "No se pudo eliminar");
            resp.sendRedirect(req.getContextPath() + "/pagos");
            return;
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private static long parseLong(String s, long def) {
        try {
            return Long.parseLong(s);
        } catch (Exception e) {
            return def;
        }
    }
}
