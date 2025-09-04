package com.prometheus.web.servlets;

import com.prometheus.web.model.Property;
import com.prometheus.web.repo.PropertyRepository;
import com.prometheus.web.util.Pagination;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {
    "/propiedades", // GET listar
    "/propiedades/", // GET listar
    "/propiedades/listar", // GET listar
    "/propiedades/crear", // GET (form crear/editar)
    "/propiedades/guardar", // POST (crear o editar)
    "/propiedades/eliminar" // POST (eliminar)
})
public class PropertyServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("text/html;charset=UTF-8");

    String uri = req.getRequestURI();

    if (uri.endsWith("/propiedades") ||
        uri.endsWith("/propiedades/") ||
        uri.endsWith("/propiedades/listar")) {

      var p = Pagination.readParams(req);
      var pr = PropertyRepository.searchPage(p.q, p.page, p.size);
      Pagination.fill(req, p, pr);

      req.setAttribute("active", "propiedades");

      req.getRequestDispatcher("/propiedades/listar.jsp").forward(req, resp);
      return;
    }

    // FORM CREAR / EDITAR
    if (uri.endsWith("/propiedades/crear")) {
      long id = parseLong(req.getParameter("id"), 0);
      if (id > 0) {
        Property p = PropertyRepository.findById(id);
        if (p == null) {
          resp.sendError(HttpServletResponse.SC_NOT_FOUND);
          return;
        }
        req.setAttribute("item", p); // ← si existe, modo edición
      }
      req.getRequestDispatcher("/propiedades/crear.jsp").forward(req, resp);
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
    if (uri.endsWith("/propiedades/guardar")) {
      long id = parseLong(req.getParameter("id"), 0);

      Property p = (id > 0) ? PropertyRepository.findById(id) : new Property();
      if (id > 0 && p == null) {
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        return;
      }
      p.setNombre(req.getParameter("nombre"));
      p.setDireccion(req.getParameter("direccion"));
      p.setDescripcion(req.getParameter("descripcion"));
      p.setRentado("si".equalsIgnoreCase(req.getParameter("rentado")));

      PropertyRepository.save(p);

      if (id > 0) {
        PropertyRepository.update(p);
        req.getSession().setAttribute("msg", "Propiedad actualizada");
      } else {
        PropertyRepository.save(p);
        req.getSession().setAttribute("msg", "Propiedad creada");
      }

      // Si es creación y presionó "Crear y crear otro"
      String again = req.getParameter("again");
      if (id == 0 && "1".equals(again)) {
        resp.sendRedirect(req.getContextPath() + "/propiedades/crear");
        return;
      }

      resp.sendRedirect(req.getContextPath() + "/propiedades");
      return;
    }

    // ELIMINAR
    if (uri.endsWith("/propiedades/eliminar")) {
      long id = parseLong(req.getParameter("id"), -1);
      boolean ok = PropertyRepository.deleteById(id);
      req.getSession().setAttribute("msg", ok ? "Propiedad eliminada" : "No se pudo eliminar");
      resp.sendRedirect(req.getContextPath() + "/propiedades");
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
