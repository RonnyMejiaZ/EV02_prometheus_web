package com.prometheus.web.servlets;

import com.prometheus.web.model.Inquilino;
import com.prometheus.web.repo.InquilinoRepository;
import com.prometheus.web.util.Pagination;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {
    "/inquilinos", // GET listar
    "/inquilinos/", // GET listar
    "/inquilinos/listar", // GET listar
    "/inquilinos/crear", // GET (form crear/editar)
    "/inquilinos/guardar", // POST (crear o editar)
    "/inquilinos/eliminar" // POST (eliminar)
})
public class InquilinoServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("text/html;charset=UTF-8");

    String uri = req.getRequestURI();

    if (uri.endsWith("/inquilinos") ||
        uri.endsWith("/inquilinos/") ||
        uri.endsWith("/inquilinos/listar")) {

      var p = Pagination.readParams(req);
      var pr = InquilinoRepository.searchPage(p.q, p.page, p.size);
      Pagination.fill(req, p, pr);

      req.setAttribute("active", "inquilinos");

      req.getRequestDispatcher("/inquilinos/listar.jsp").forward(req, resp);
      return;
    }

    // FORM CREAR / EDITAR
    if (uri.endsWith("/inquilinos/crear")) {
      long id = parseLong(req.getParameter("id"), 0);
      if (id > 0) {
        Inquilino p = InquilinoRepository.findById(id);
        if (p == null) {
          resp.sendError(HttpServletResponse.SC_NOT_FOUND);
          return;
        }
        req.setAttribute("item", p); // ← si existe, modo edición
      }
      req.getRequestDispatcher("/inquilinos/crear.jsp").forward(req, resp);
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
    if (uri.endsWith("/inquilinos/guardar")) {
      long id = parseLong(req.getParameter("id"), 0);

      Inquilino p = (id > 0) ? InquilinoRepository.findById(id) : new Inquilino();
      if (id > 0 && p == null) {
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        return;
      }
      p.setNombre(req.getParameter("nombre"));
      p.setDocumento(req.getParameter("documento"));
      p.setTelefono(req.getParameter("telefono"));

      InquilinoRepository.save(p);

      if (id > 0) {
        InquilinoRepository.update(p);
        req.getSession().setAttribute("msg", "Inquilino actualizado");
      } else {
        InquilinoRepository.save(p);
        req.getSession().setAttribute("msg", "Inquilino creado");
      }

      // Si es creación y presionó "Crear y crear otro"
      String again = req.getParameter("again");
      if (id == 0 && "1".equals(again)) {
        resp.sendRedirect(req.getContextPath() + "/inquilinos/crear");
        return;
      }

      resp.sendRedirect(req.getContextPath() + "/inquilinos");
      return;
    }

    // ELIMINAR
    if (uri.endsWith("/inquilinos/eliminar")) {
      long id = parseLong(req.getParameter("id"), -1);
      boolean ok = InquilinoRepository.deleteById(id);
      req.getSession().setAttribute("msg", ok ? "Inquilino eliminado" : "No se pudo eliminar");
      resp.sendRedirect(req.getContextPath() + "/inquilinos");
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
