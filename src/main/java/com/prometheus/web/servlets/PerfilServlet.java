package com.prometheus.web.servlets;

import com.prometheus.web.model.Perfil;
import com.prometheus.web.repo.PerfilRepository;
import com.prometheus.web.util.Pagination;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {
        "/perfil", // GET listar
        "/perfil/", // GET listar
        "/perfil/listar", // GET listar
        "/perfil/crear", // GET (form crear/editar)
        "/perfil/guardar", // POST (crear o editar)
        "/perfil/eliminar" // POST (eliminar)
})
public class PerfilServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String uri = req.getRequestURI();

        if (uri.endsWith("/perfil") ||
                uri.endsWith("/perfil/") ||
                uri.endsWith("/perfil/listar")) {

            var p = Pagination.readParams(req);
            var pr = PerfilRepository.searchPage(p.q, p.page, p.size);
            Pagination.fill(req, p, pr);

            req.setAttribute("active", "perfil");

            req.getRequestDispatcher("/perfil/listar.jsp").forward(req, resp);
            return;
        }

        // FORM CREAR / EDITAR
        if (uri.endsWith("/perfil/crear")) {
            long id = parseLong(req.getParameter("id"), 0);
            if (id > 0) {
                Perfil p = PerfilRepository.findById(id);
                if (p == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                req.setAttribute("item", p); // ← si existe, modo edición
            }
            req.getRequestDispatcher("/perfil/crear.jsp").forward(req, resp);
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
        // req.getParameterMap().forEach((k, v) -> System.out.println("  " + k + " => " + java.util.Arrays.toString(v)));
        // System.out.println("===================================\n");

        String uri = req.getRequestURI();

        // CREAR o EDITAR (un solo endpoint)
        if (uri.endsWith("/perfil/guardar")) {
            long id = parseLong(req.getParameter("id"), 0);

            Perfil p = (id > 0) ? PerfilRepository.findById(id) : new Perfil();
            if (id > 0 && p == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            p.setNombre(req.getParameter("nombre"));
            p.setDocumento(req.getParameter("documento"));
            p.setTelefono(req.getParameter("telefono"));
            p.setCorreo(req.getParameter("correo"));
            p.setContraseña(req.getParameter("contraseña"));

            PerfilRepository.save(p);


            // if (id > 0) {
            //     PerfilRepository.save(p);
            //     req.getSession().setAttribute("msg", "Perfil actualizado");
            // } 
            // else {
            //     PerfilRepository.save(p);
            //     req.getSession().setAttribute("msg", "Perfil creado");
            // }

            // // Si es creación y presionó "Crear y crear otro"
            // String again = req.getParameter("again");
            // if (id == 0 && "1".equals(again)) {
            //     resp.sendRedirect(req.getContextPath() + "/perfil/crear");
            //     return;
            // }

            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        // // ELIMINAR
        // if (uri.endsWith("/perfil/eliminar")) {
        //     long id = parseLong(req.getParameter("id"), -1);
        //     boolean ok = PerfilRepository.deleteById(id);
        //     req.getSession().setAttribute("msg", ok ? "Perfil eliminado" : "No se pudo eliminar");
        //     resp.sendRedirect(req.getContextPath() + "/perfil");
        //     return;
        // }

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
