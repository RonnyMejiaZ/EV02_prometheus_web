<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="com.prometheus.web.model.Perfil" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="com.prometheus.web.model.User" %>
<% User u=(User) session.getAttribute("user");
                      if (u==null) {
                      response.sendRedirect(request.getContextPath()+"/login.jsp"); return; }
%>
<%
  String ctx = request.getContextPath();
  Perfil item = (Perfil) request.getAttribute("item"); // null => crear
  boolean editing = (item != null);
%>

<c:set var="title" value="Perfil"/>
<c:set var="active" value="perfil"/>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= editing ? "Editar" : "Agregar " %><c:out value="${title}" default="Propiedad"/></title>
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
        <div class="logo">P</div>
        <span class="logo-text">PROMETHEUS</span>
      </div>
      <nav>
        <ul class="nav-menu">
          <li class="nav-item"><a href="<%=ctx%>/dashboard" class="nav-link active"><span class="nav-icon">📊</span> Dashboard</a></li>
            <li class="nav-item"><a href="<%=ctx%>/propiedades/listar" class="nav-link"><span class="nav-icon">🏠</span> Propiedades</a></li>
            <li class="nav-item"><a href="<%=ctx%>/inquilinos/listar" class="nav-link"><span class="nav-icon">👥</span> Inquilinos</a></li>
            <li class="nav-item"><a href="<%=ctx%>/alquileres/listar" class="nav-link"><span class="nav-icon">📋</span> Alquileres</a></li>
            <li class="nav-item"><a href="<%=ctx%>/pagos/listar" class="nav-link"><span class="nav-icon">💰</span> Planes de Pagos</a></li>
            <li class="nav-item"><a href="<%=ctx%>/perfil/listar" class="nav-link"><span class="nav-icon">👤</span> Perfil</a></li>
        </ul>
      </nav>
    </aside>

    <main class="main-content">
      <div class="topbar">
        <button class="mobile-menu-toggle" onclick="toggleSidebar()">☰</button>
        <h1 class="page-title"><%= editing ? "Editar " : "Editar " %><c:out value="${title}"/></h1>
        <div class="user-menu">
          <a class="btn btn-secondary btn-sm" href="<%=ctx%>/logout">Cerrar sesión</a>
        </div>
      </div>

      <nav style="margin-bottom: var(--spacing-lg);">
        <span style="color: var(--text-muted);">
          <a href="<%=ctx%>/propiedades" style="color: var(--primary-color);"><c:out value="${title}"/></a> > <%="Editar" %>
        </span>
      </nav>

      <div class="card">
        <div class="card-header">
          <h2 class="card-title"><%= editing ? "Editar datos" : "Información de tu " %><c:out value="${active}"/></h2>
        </div>

<form id="f" method="post" action="<%=ctx%>/perfil/guardar">
 
          <input type="hidden" name="id" value="<%= editing ? item.getId() : 0 %>">
          <% if (!editing) { %><input type="hidden" id="again" name="again" value=""><% } %>

          <div style="display:grid;grid-template-columns:1fr 1fr;gap:var(--spacing-lg);margin-bottom:var(--spacing-lg);">


            <div class="form-group">
              <label class="form-label" for="nombre">Nombre</label>
              <input type="text" id="nombre" name="nombre" class="form-control" 
                   value="<%= u.getName() %>" required>
            </div>
          
            <div class="form-group">
              <label class="form-label" for="documento">Documento</label>
              <input type="text" id="documento" name="documento" class="form-control"
                     value="<%= editing ? item.getDocumento() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="telefono">Teléfono</label>
              <input type="text" id="telefono" name="telefono" class="form-control"
                     value="<%= editing ? item.getTelefono() : "" %>" >
            </div>
          
            <div class="form-group">
              <label class="form-label" for="correo">Correo Electrónico</label>
              <input type="text" id="correo" name="correo" class="form-control"
                     value="<%= u.getEmail() %>" required>
            </div>


          <div style="display:flex;gap:var(--spacing-md);justify-content:flex-end;margin-top:var(--spacing-xl);">
            <button type="submit" class="btn btn-primary"><%= "Guardar" %></button>
            <a href="<%=ctx%>/<c:out value="${active}/listar"/>" class="btn btn-secondary">Cancelar</a>
          </div>
        </form>
      </div>
    </main>
  </div>

  <script src="<%=ctx%>/js/navigation.js"></script>
  <script>
    function submitAndNew() {
      document.getElementById('again').value = '1';
      document.getElementById('f').submit();
    }
  </script>
</body>
</html>
