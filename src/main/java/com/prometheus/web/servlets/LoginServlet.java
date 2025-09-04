package com.prometheus.web.servlets;

import com.prometheus.web.repo.UserRepository;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.getRequestDispatcher("/login.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("text/html; charset=UTF-8");
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    if (UserRepository.validate(email, password)) {
      HttpSession session = req.getSession(true);
      session.setAttribute("user", UserRepository.find(email));
      resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
    } else {
      req.setAttribute("error", "Credenciales inválidas");
      req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
  }
}