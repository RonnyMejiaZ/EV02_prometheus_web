<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="java.util.*,java.time.format.DateTimeFormatter,com.prometheus.web.model.Perfil" %>
<%@ page import="com.prometheus.web.model.User" %>
<% User u=(User) session.getAttribute("user");
                      if (u==null) {
                      response.sendRedirect(request.getContextPath()+"/login.jsp"); return; }
%>

<%
  String ctx = request.getContextPath();
  List<Perfil> items = (List<Perfil>) request.getAttribute("items");
  String q     = (String) request.getAttribute("q");
  Integer currentPage  = (Integer) request.getAttribute("page");
  Integer totalPages = (Integer) request.getAttribute("pages");
  DateTimeFormatter df = DateTimeFormatter.ofPattern("d/MM/yy");
  if (items == null) items = Collections.emptyList();
  String msg = (String) request.getAttribute("msg");
  if (msg != null) { request.removeAttribute("msg"); }
%>
<c:set var="title" value="Perfil"/>
<c:set var="active" value="perfil"/>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title><c:out value="${title}" default="Prometheus" /></title>
  <link rel="stylesheet" href="<%=ctx%>/css/reset.css">
  <link rel="stylesheet" href="<%=ctx%>/css/variables.css">
  <link rel="stylesheet" href="<%=ctx%>/css/components.css">
  <link rel="stylesheet" href="<%=ctx%>/css/layout.css">
  <link rel="stylesheet" href="<%=ctx%>/css/responsive.css">
</head>
<body>
<div class="app-layout">
  <aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
      <div class="logo">P</div><span class="logo-text">PROMETHEUS</span>
    </div>
    <nav>
      <ul class="nav-menu">
        <li class="nav-item"><a href="<%=ctx%>/dashboard.jsp" class="nav-link active"><span class="nav-icon">📊</span> Dashboard</a></li>
        <li class="nav-item"><a href="<%=ctx%>/propiedades/listar" class="nav-link"><span class="nav-icon">🏠</span> Propiedades</a></li>
        <li class="nav-item"><a href="<%=ctx%>/inquilinos/listar" class="nav-link"><span class="nav-icon">👥</span> Inquilinos</a></li>
        <li class="nav-item"><a href="<%=ctx%>/alquileres/listar" class="nav-link"><span class="nav-icon">📋</span> Alquileres</a></li>
        <li class="nav-item"><a href="<%=ctx%>/pagos/listar" class="nav-link"><span class="nav-icon">💰</span> Planes de Pagos</a></li>
        <li class="nav-item"><a href="<%=ctx%>/perfil/listar" class="nav-link"><span class="nav-icon">👤</span> Perfil</a></li>
    </nav>
  </aside>

  <main class="main-content">
    <div class="topbar">
      <button class="mobile-menu-toggle" onclick="toggleSidebar()">☰</button>
      <h1 class="page-title"><c:out value="${title}"/></h1>
      <div class="user-menu">
        <a class="btn btn-secondary btn-sm" href="<%=ctx%>/logout">Cerrar sesión</a>
      </div>
    </div>

    <% if (msg != null) { %>
      <div class="badge badge-success" style="margin-bottom:1rem;"><%= msg %></div>
    <% } %>


    <div class="card">
      <div class="card-header" style="display:flex;justify-content:space-between;align-items:center;">
        <h2 class="card-title">Tu Información Personal</h2>
        <% if (items.isEmpty()) { %>
            <a class="btn btn-primary" href="<%=ctx%>/<c:out value="${active}"/>/crear">Editar <c:out value="${title}"/></a>
        <% } else { 
            for (Perfil p : items) { %>
            <a class="btn btn-primary" href="<%=ctx%>/<c:out value="${active}"/>/crear?id=<%=p.getId()%>">Editar <c:out value="${title}"/></a>
        <% } } %>

      </div>

      <table class="table">
        <thead>
          <tr>
            <th>Nombre</th><th>Correo</th>
          </tr>
        </thead>
        <tbody>
                  <tr>
                      <td><%= u.getName() %></td>
                      <td><%= u.getEmail() %></td>
        <% if (items.isEmpty()) { %>
            <tr><td colspan="4">Complete su <c:out value="${active}"/>.</td></tr>
        <% } else {
              for (Perfil p : items) { %>
                    <tr>
                      <th>Documento</th><th>Teléfono</th>
                    </tr>
                  <tr>
                      <td><%= p.getDocumento() %></td>
                      <td><%= p.getTelefono() %></td>
                  </tr><% } } %>
        </tbody>
      </table>
    </div>
  </main>
</div>
<script src="<%=ctx%>/js/navigation.js"></script>
</body>
</html>       
