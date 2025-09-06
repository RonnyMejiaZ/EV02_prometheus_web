<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="com.prometheus.web.model.User" %>
    <%@ page import="com.prometheus.web.model.Alquiler" %>
      <%@ page import="com.prometheus.web.model.Inquilino" %>
        <%@ page import="java.util.*,com.prometheus.web.model.Alquiler" %>
          <%@ page import="java.util.*,com.prometheus.web.model.Inquilino" %>
            <%@ page import="java.math.BigDecimal, java.math.RoundingMode" %>


              <% List<Alquiler> items = (List<Alquiler>) request.getAttribute("items");
                  List<Inquilino> inquilinoItems = (List<Inquilino>) request.getAttribute("inquilinoItems");
                      User u=(User) session.getAttribute("user");
                      if (u==null) {
                      response.sendRedirect(request.getContextPath()+"/login.jsp"); return; } String
                      ctx=request.getContextPath();
                      String initials="U" ; if (u.getName() !=null && !u.getName().isBlank()) { String[]
                      parts=u.getName().trim().split("\\s+"); initials=(parts.length>= 2)
                      ? ("" + parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase()
                      : ("" + u.getName().charAt(0)).toUpperCase();
                      }
                      %>

                      <% BigDecimal totalMonto=(BigDecimal) request.getAttribute("totalMonto"); if (totalMonto==null)
                        totalMonto=BigDecimal.ZERO; 
                        java.text.DecimalFormat dfUS = new java.text.DecimalFormat("#,##0.00");
String copUS = "COP " + dfUS.format(totalMonto.setScale(2, java.math.RoundingMode.HALF_UP));
                        
                        %>

                        <!DOCTYPE html>
                        <html lang="es">

                        <head>
                          <meta charset="UTF-8" />
                          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                          <title>Dashboard - Prometheus</title>

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
                                  <li class="nav-item"><a href="<%=ctx%>/dashboard" class="nav-link active"><span
                                        class="nav-icon">📊</span> Dashboard</a></li>
                                  <li class="nav-item"><a href="<%=ctx%>/propiedades/listar" class="nav-link"><span
                                        class="nav-icon">🏠</span> Propiedades</a></li>
                                  <li class="nav-item"><a href="<%=ctx%>/inquilinos/listar" class="nav-link"><span
                                        class="nav-icon">👥</span> Inquilinos</a></li>
                                  <li class="nav-item"><a href="<%=ctx%>/alquileres/listar" class="nav-link"><span
                                        class="nav-icon">📋</span> Alquileres</a></li>
                                  <li class="nav-item"><a href="<%=ctx%>/pagos/listar" class="nav-link"><span
                                        class="nav-icon">💰</span>
                                      Planes de Pagos</a></li>
                                  <li class="nav-item"><a href="<%=ctx%>/perfil/listar" class="nav-link"><span
                                        class="nav-icon">👤</span> Perfil</a></li>
                                </ul>
                              </nav>
                            </aside>

                            <!-- Main Content -->
                            <main class="main-content">
                              <div class="topbar">
                                <button class="mobile-menu-toggle" onclick="toggleSidebar()">☰</button>
                                <h1 class="page-title">Dashboard</h1>

                                <div class="user-menu">
                                  <div class="user-avatar">
                                    <%= initials %>
                                  </div>
                                  <span>
                                    <%= u.getName() %>
                                  </span>
                                  <a class="btn btn-secondary btn-sm" href="<%=ctx%>/logout">Cerrar sesión</a>
                                </div>
                              </div>

                              <!-- Filtros del Dashboard -->
                              <div class="form-group">
                                <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:var(--spacing-lg);margin-bottom:var(--spacing-md);">
                                  <form method="get" action="<%=ctx%>/dashboard">
                                    <label class="form-label">Solo alquileres activos</label>
                                    <select class="form-control" name="activo">
                                      <option value="" <%="" .equals(String.valueOf(request.getAttribute("f_activo")))
                                        ? "selected" : "" %> >Todos</option>
                                      <option value="1" <%="1" .equals(String.valueOf(request.getAttribute("f_activo")))
                                        ? "selected" : "" %>
                                        >Solo activos</option>
                                      <option value="0" <%="0" .equals(String.valueOf(request.getAttribute("f_activo")))
                                        ? "selected" : "" %>
                                        >Solo inactivos</option>
                                    </select>
                                </div>

                              <div class="form-group">
                                <label class="form-label">Fecha Inicio</label>
                                <input type="date" class="form-control" name="fi"
                                  value="<%= String.valueOf(request.getAttribute(" f_fi")==null? "" :
                                  request.getAttribute("f_fi")) %>">
                              </div>

                              <div class="form-group">
                                <label class="form-label">Fecha Fin</label>
                                <input type="date" class="form-control" name="ff"
                                  value="<%= String.valueOf(request.getAttribute(" f_ff")==null? "" :
                                  request.getAttribute("f_ff")) %>">
                              </div>
                          </div>

                          <div style="margin-top:var(--spacing-md); display:flex; gap:var(--spacing-md);margin-bottom:var(--spacing-md);">
                            <button type="submit" class="btn btn-primary">Filtrar</button>
                            <a class="btn btn-secondary" href="<%=ctx%>/dashboard">Limpiar</a>
                          </div>
                          </form>

                          <!-- Tarjetas de métricas -->
                          <div
                            style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:var(--spacing-lg);margin-bottom:var(--spacing-xl);">
                            <div class="card">
                              <h3
                                style="color:var(--text-secondary);font-size:var(--font-size-sm);margin-bottom:var(--spacing-sm);">
                                Ganancia</h3>
                              <div
                                style="font-size:var(--font-size-2xl);font-weight:600;margin-bottom:var(--spacing-sm);">
                                <%= totalMonto.setScale(2, RoundingMode.HALF_UP).toPlainString() %> COP
                              </div>
                            </div>

                            <div class="card">
                              <h3
                                style="color:var(--text-secondary);font-size:var(--font-size-sm);margin-bottom:var(--spacing-sm);">
                                Nuevos clientes</h3>
                              <div
                                style="font-size:var(--font-size-2xl);font-weight:600;margin-bottom:var(--spacing-sm);">
                                <%= java.util.Objects.toString(request.getAttribute("clientesNuevos"), "0") %>
                              </div>
                            </div>

                            <div class="card">
                              <h3
                                style="color:var(--text-secondary);font-size:var(--font-size-sm);margin-bottom:var(--spacing-sm);">
                                Nuevos alquileres</h3>
                              <div
                                style="font-size:var(--font-size-2xl);font-weight:600;margin-bottom:var(--spacing-sm);">
                                <%= java.util.Objects.toString(request.getAttribute("alquileresNuevos"), "0") %>
                              </div>
                            </div>
                          </div>
                          </main>
                          </div>

                          <!-- JS -->
                          <script>
                            const BASE = '<%=ctx%>';
                            function toggleSidebar() { document.getElementById('sidebar').classList.toggle('open'); }
                            function logout() { window.location.href = BASE + '/logout'; }
                          </script>
                          <script src="<%=ctx%>/js/navigation.js"></script>
                        </body>

                        </html>