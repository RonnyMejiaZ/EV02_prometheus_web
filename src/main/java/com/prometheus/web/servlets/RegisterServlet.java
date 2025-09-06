package com.prometheus.web.servlets;

import com.prometheus.web.model.User;
import com.prometheus.web.repo.UserRepository;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.concurrent.ThreadLocalRandom;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

  private static long timeRandomId() {
    long millis = System.currentTimeMillis(); // 13 dígitos
    int rnd = ThreadLocalRandom.current().nextInt(1000, 10_000); // 4 dígitos
    return millis * 10_000L + rnd; // ~17 dígitos
  }

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

    long userId = timeRandomId();

    boolean ok = UserRepository.save(new User(userId, name, email, password));
    String ctx = req.getContextPath();
    if (ok) {
      // mensaje “flash” en sesión para mostrarlo tras el redirect
      // req.getSession().setAttribute("msg", "Registro exitoso.");
      resp.setStatus(HttpServletResponse.SC_FOUND); // 302 (opcional, sendRedirect ya lo hace)
      resp.sendRedirect(ctx + "/login.jsp"); // <- 302
    } else {
      req.getSession().setAttribute("error", "El correo ya existe o datos inválidos.");
      resp.sendRedirect(ctx + "/register"); // <- 302
    }
  }
}