package com.prometheus.web.servlets;

import com.prometheus.web.model.User;
import com.prometheus.web.repo.UserRepository;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.getRequestDispatcher("/registro.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("text/html; charset=UTF-8");
    String name = req.getParameter("name");
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    boolean ok = UserRepository.save(new User(name, email, password));
    String ctx = req.getContextPath();
    if (ok) {
      // mensaje “flash” en sesión para mostrarlo tras el redirect
      req.getSession().setAttribute("msg", "Registro exitoso. Inicia sesión.");
      resp.setStatus(HttpServletResponse.SC_FOUND); // 302 (opcional, sendRedirect ya lo hace)
      resp.sendRedirect(ctx + "/login.jsp"); // <- 302
    } else {
      req.getSession().setAttribute("error", "El correo ya existe o datos inválidos.");
      resp.sendRedirect(ctx + "/register"); // <- 302
    }
  }
}