package com.prometheus.web.servlets;

import com.prometheus.web.model.Alquiler;
import com.prometheus.web.repo.AlquilerRepository;
import com.prometheus.web.repo.InquilinoRepository;
import com.prometheus.web.repo.PropertyRepository;
import com.prometheus.web.util.Pagination;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.math.BigDecimal;

@WebServlet(urlPatterns = {
    "/alquileres", // GET listar
    "/alquileres/", // GET listar
    "/alquileres/listar", // GET listar
    "/alquileres/crear", // GET (form crear/editar)
    "/alquileres/guardar", // POST (crear o editar)
    "/alquileres/eliminar" // POST (eliminar)
})
public class AlquilerServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("text/html;charset=UTF-8");

    String uri = req.getRequestURI();

    if (uri.endsWith("/alquileres") ||
        uri.endsWith("/alquileres/") ||
        uri.endsWith("/alquileres/listar")) {

      var p = Pagination.readParams(req);
      var pr = AlquilerRepository.searchPage(p.q, p.page, p.size);
      Pagination.fill(req, p, pr);

      req.setAttribute("active", "alquileres");

      req.getRequestDispatcher("/alquileres/listar.jsp").forward(req, resp);
      return;
    }

    // FORM CREAR / EDITAR
    if (uri.endsWith("/alquileres/crear")) {
      long id = parseLong(req.getParameter("id"), 0);
      if (id > 0) {
        Alquiler p = AlquilerRepository.findById(id);
        if (p == null) {
          resp.sendError(HttpServletResponse.SC_NOT_FOUND);
          return;
        }
        req.setAttribute("item", p); // ← si existe, modo edición
        req.setAttribute("inquilinos", InquilinoRepository.findAll());
        req.setAttribute("propiedades", PropertyRepository.findAll());
      }
      req.setAttribute("inquilinos", InquilinoRepository.findAll());
      req.setAttribute("propiedades", PropertyRepository.findAll());
      req.getRequestDispatcher("/alquileres/crear.jsp").forward(req, resp);
      return;
    }

    resp.sendError(HttpServletResponse.SC_NOT_FOUND);

  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");

    // System.out.println("\n=== PerfilServlet.doPost params ===");
    //     req.getParameterMap().forEach((k, v) -> System.out.println("  " + k + " => " + java.util.Arrays.toString(v)));
    //     System.out.println("===================================\n");

    String uri = req.getRequestURI();

    // CREAR o EDITAR (un solo endpoint)
    if (uri.endsWith("/alquileres/guardar")) {
      long id = parseLong(req.getParameter("id"), 0);

      Alquiler p = (id > 0) ? AlquilerRepository.findById(id) : new Alquiler();
      if (id > 0 && p == null) {
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        return;
      }
      p.setFechaInicio(LocalDate.parse(req.getParameter("fechaInicio")));
      p.setFechaFin(LocalDate.parse(req.getParameter("fechaFin")));
      p.setMontoMensual(new BigDecimal(req.getParameter("montoMensual")));
      p.setMeses(Integer.parseInt(req.getParameter("meses")));
      p.setPersonas(Integer.parseInt(req.getParameter("personas")));
      p.setActivo("1".equals(req.getParameter("activo")));
      p.setContrato(req.getParameter("contrato"));
      p.setInquilinoId(parseLong(req.getParameter("inquilinoId"), 0));
      p.setPropiedadId(parseLong(req.getParameter("propiedadId"), 0));

      AlquilerRepository.save(p);

      if (id > 0) {
        AlquilerRepository.update(p);
        req.getSession().setAttribute("msg", "Alquiler actualizado");
      } else {
        AlquilerRepository.save(p);
        req.getSession().setAttribute("msg", "Alquiler creado");
      }

      // Si es creación y presionó "Crear y crear otro"
      String again = req.getParameter("again");
      if (id == 0 && "1".equals(again)) {
        resp.sendRedirect(req.getContextPath() + "/alquileres/crear");
        return;
      }

      resp.sendRedirect(req.getContextPath() + "/alquileres");
      return;
    }

    // ELIMINAR
    if (uri.endsWith("/alquileres/eliminar")) {
      long id = parseLong(req.getParameter("id"), -1);
      boolean ok = AlquilerRepository.deleteById(id);
      req.getSession().setAttribute("msg", ok ? "Alquiler eliminado" : "No se pudo eliminar");
      resp.sendRedirect(req.getContextPath() + "/alquileres");
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
